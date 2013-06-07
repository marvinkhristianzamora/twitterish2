CREATE TABLE "microposts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "content" varchar(255), "user_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "email" varchar(255), "created_at" datetime, "updated_at" datetime, "password_digest" varchar(255), "remember_token" varchar(255), "admin" boolean DEFAULT 'f');
CREATE INDEX "index_microposts_on_user_id_and_created_at" ON "microposts" ("user_id", "created_at");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE INDEX "index_users_on_remember_token" ON "users" ("remember_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20130531025919');

INSERT INTO schema_migrations (version) VALUES ('20130531043003');

INSERT INTO schema_migrations (version) VALUES ('20130531060443');

INSERT INTO schema_migrations (version) VALUES ('20130605044649');

INSERT INTO schema_migrations (version) VALUES ('20130606081819');

INSERT INTO schema_migrations (version) VALUES ('20130607074053');
