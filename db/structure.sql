CREATE TABLE "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "admins" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar, "last_sign_in_ip" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "username" varchar, "authorization" varchar);
CREATE UNIQUE INDEX "index_admins_on_email" ON "admins" ("email");
CREATE UNIQUE INDEX "index_admins_on_reset_password_token" ON "admins" ("reset_password_token");
CREATE UNIQUE INDEX "index_admins_on_username" ON "admins" ("username");
CREATE TABLE "contacts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "email" varchar, "comments" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "conversations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "sender_id" integer, "recipient_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "messages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "body" text, "conversation_id" integer, "user_id" integer, "read" boolean DEFAULT 'f', "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_messages_on_conversation_id" ON "messages" ("conversation_id");
CREATE INDEX "index_messages_on_user_id" ON "messages" ("user_id");
CREATE TABLE "pets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "name" varchar, "color" varchar, "species" varchar, "level" integer, "hp" integer, "strength" integer, "defence" integer, "movement" integer, "hsd" integer, "uc" boolean, "rw" boolean, "rn" boolean, "verified" boolean DEFAULT 'f', "description" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "uft" boolean, "ufa" boolean, "gender" varchar);
CREATE TABLE "profiles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "title" varchar, "description" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "avatar_file_name" varchar, "avatar_content_type" varchar, "avatar_file_size" integer, "avatar_updated_at" datetime, "admin_id" integer, "neoname" varchar);
CREATE TABLE "report_forms" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "issue" varchar, "body" text, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_report_forms_on_user_id" ON "report_forms" ("user_id");
CREATE TABLE "reports" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "issue" varchar, "body" text, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_reports_on_user_id" ON "reports" ("user_id");
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar, "last_sign_in_ip" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "username" varchar, "moderator" boolean DEFAULT 'f', "banned" boolean DEFAULT 'f');
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "index_users_on_username" ON "users" ("username");
INSERT INTO schema_migrations (version) VALUES ('20170118151300'), ('20170119202923'), ('20170119203013'), ('20170119203138'), ('20170119203344'), ('20170120022930'), ('20170120065130'), ('20170121021526'), ('20170121182559'), ('20170122033015'), ('20170122191818'), ('20170123163147'), ('20170124225442'), ('20170126223014'), ('20170126223134'), ('20170128010754'), ('20170128163728'), ('20170130161434'), ('20170326023030');


