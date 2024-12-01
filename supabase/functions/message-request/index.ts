// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'
import serviceAccount from '../service-account.json' with { type: 'json' }

interface Message{
  id: String
  sender_id: String
  message_text: String
  conversation_id: String
  is_read: Boolean
  sender_name: String
  encrypted: Boolean
}

interface WebhookPayload {
  type: 'INSERT'
  table: string
  record: Message
  schema: 'public'
}

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

Deno.serve(async (req) => {
  const payload: WebhookPayload = await req.json();

  // Fetch conversation details to check if it's a group
  const { data: conversation } = await supabase
  .from('conversation')
  .select('title, is_group')
  .eq('id', payload.record.conversation_id)
  .single();
  // Retrieve participants in the conversation
  const { data: participants } = await supabase
    .from('participants')
    .select('users_id')
    .eq('conversation_id', payload.record.conversation_id);

  // Filter recipient IDs (exclude sender ID)
  const recipientIds = participants
    ?.map((p) => p.users_id)
    .filter((userId) => userId !== payload.record.sender_id);

  // Fetch FCM tokens for all recipients
  const { data: recipients } = await supabase
    .from('users')
    .select('fcm_token')
    .in('id', recipientIds);

  const fcmTokens = recipients?.map((r) => r.fcm_token).filter(Boolean);

  if (fcmTokens && fcmTokens.length > 0) {
    // Generate notification content based on whether it's a group or one-to-one conversation
    const notificationTitle = conversation.is_group
      ? `${payload.record.sender_name} in ${conversation.title}`
      : `${payload.record.sender_name}`;

    const notificationBody = `${payload.record.message_text}`;

    // Send notifications to all recipients
    const accessToken = await getAccessToken({
      clientEmail: serviceAccount.client_email,
      privateKey: serviceAccount.private_key,
    });

    await Promise.all(
      fcmTokens.map(async (token) => {
        const res = await fetch(
          `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
          {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              Authorization: `Bearer ${accessToken}`,
            },
            body: JSON.stringify({
              message: {
                token,
                notification: {
                  title: notificationTitle,
                  body: notificationBody,
                },
              },
            }),
          }
        );

        if (res.status < 200 || res.status > 299) {
          console.error('Failed to send notification', await res.json());
        }
      })
    );
  }

  return new Response(
    JSON.stringify({ message: 'Notifications sent successfully' }),
    { headers: { 'Content-Type': 'application/json' } }
  );
});

const getAccessToken = ({
  clientEmail,
  privateKey,
}: {
  clientEmail: string
  privateKey: string
}): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    })
    jwtClient.authorize((err, tokens) => {
      if (err) {
        reject(err)
        return
      }
      resolve(tokens!.access_token!)
    })
  })
}