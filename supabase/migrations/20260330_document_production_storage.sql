alter table public.batch_runs
add column if not exists bundle_storage_path text;

alter table public.batch_documents
add column if not exists cleaned_doc_storage_path text,
add column if not exists report_storage_path text;

insert into storage.buckets (id, name, public)
values ('document-production', 'document-production', false)
on conflict (id) do nothing;

-- Storage policies are created by the auth_lockdown migration.
-- They scope access to authenticated users reading/writing under their own userId prefix.
