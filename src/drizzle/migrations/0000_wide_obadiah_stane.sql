CREATE TABLE IF NOT EXISTS "address_table" (
	"address_id" integer PRIMARY KEY NOT NULL,
	"street_address_1" varchar NOT NULL,
	"street_address_2" varchar,
	"zip_code" varchar NOT NULL,
	"delivery_instructions" varchar,
	"user_id" integer NOT NULL,
	"city_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"city" varchar NOT NULL,
	"users" varchar NOT NULL,
	"orders" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "category_table" (
	"category_id" integer PRIMARY KEY NOT NULL,
	"category_name" text NOT NULL,
	"menu_item" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "city_table" (
	"city_id" integer PRIMARY KEY NOT NULL,
	"city_name" text NOT NULL,
	"state_id" integer NOT NULL,
	"address" varchar NOT NULL,
	"state" varchar NOT NULL,
	"restaurant" varchar NOT NULL,
	CONSTRAINT "city_table_city_name_unique" UNIQUE("city_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "comment_table" (
	"comment_id" integer PRIMARY KEY NOT NULL,
	"order_id" integer NOT NULL,
	"user_id" integer NOT NULL,
	"comment_text" varchar NOT NULL,
	"is_complaint" boolean NOT NULL,
	"is_praise" boolean NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"users" varchar NOT NULL,
	"orders" integer NOT NULL,
	CONSTRAINT "comment_table_comment_text_unique" UNIQUE("comment_text")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "driver_table" (
	"driver_id" integer PRIMARY KEY NOT NULL,
	"vehicle_make" varchar NOT NULL,
	"vehicle_model" varchar NOT NULL,
	"vehicle_year" varchar NOT NULL,
	"user_id" integer NOT NULL,
	"online" boolean NOT NULL,
	"delivering" boolean NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"users" varchar NOT NULL,
	"orders" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "menu_item_table" (
	"menu_item_id" integer PRIMARY KEY NOT NULL,
	"menu_item_name" text NOT NULL,
	"restaurant_id" integer NOT NULL,
	"category_id" integer NOT NULL,
	"description" text NOT NULL,
	"ingredients" text NOT NULL,
	"price" numeric NOT NULL,
	"active" boolean NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	"restaurant" varchar NOT NULL,
	"order_menu_item" integer NOT NULL,
	CONSTRAINT "menu_item_table_menu_item_name_unique" UNIQUE("menu_item_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_menu_item_table" (
	"order_menu_item_id" integer PRIMARY KEY NOT NULL,
	"order_id" integer NOT NULL,
	"menu_item_id" integer NOT NULL,
	"quantity" integer NOT NULL,
	"item_price" numeric NOT NULL,
	"price" numeric NOT NULL,
	"comment" varchar,
	"menu_item" varchar NOT NULL,
	"orders" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_status_table" (
	"order_status_id" integer PRIMARY KEY NOT NULL,
	"status_catalog_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"order" integer NOT NULL,
	"status_catalog" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "orders_table" (
	"order_id" integer PRIMARY KEY NOT NULL,
	"restaurant_id" integer NOT NULL,
	"estimated_delivery_time" timestamp NOT NULL,
	"actual_delivery_time" timestamp NOT NULL,
	"delivery_address_id" integer NOT NULL,
	"user_id" integer NOT NULL,
	"driver_id" integer NOT NULL,
	"price" numeric NOT NULL,
	"discount" numeric NOT NULL,
	"final_price" numeric NOT NULL,
	"comment" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"comments" integer NOT NULL,
	"order_menu_item" integer NOT NULL,
	"order_status" integer NOT NULL,
	"address" integer NOT NULL,
	"driver" integer NOT NULL,
	"restaurant" varchar NOT NULL,
	"users" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "restaurant_owner_table" (
	"restaurant_owner_id" integer PRIMARY KEY NOT NULL,
	"restaurant_id" integer NOT NULL,
	"owner_id" integer NOT NULL,
	"users" integer NOT NULL,
	"restaurant" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "restaurant_table" (
	"restaurant_id" integer PRIMARY KEY NOT NULL,
	"restaurant_name" text NOT NULL,
	"street_address" varchar NOT NULL,
	"zip_code" varchar NOT NULL,
	"city_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"menu_items" text NOT NULL,
	"orders" text NOT NULL,
	"city" text NOT NULL,
	"restaurant_owner" text NOT NULL,
	CONSTRAINT "restaurant_table_restaurant_name_unique" UNIQUE("restaurant_name"),
	CONSTRAINT "restaurant_table_street_address_unique" UNIQUE("street_address")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "state_table" (
	"state_id" integer PRIMARY KEY NOT NULL,
	"state_name" text NOT NULL,
	"code" text NOT NULL,
	"city" varchar NOT NULL,
	CONSTRAINT "state_table_state_name_unique" UNIQUE("state_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "status_catalog_table" (
	"status_catalog_id" integer PRIMARY KEY NOT NULL,
	"status_name" varchar NOT NULL,
	"order_status" integer NOT NULL,
	CONSTRAINT "status_catalog_table_status_name_unique" UNIQUE("status_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users_table" (
	"user_id" integer PRIMARY KEY NOT NULL,
	"user_name" varchar NOT NULL,
	"contact_phone" varchar NOT NULL,
	"phone_verified" boolean DEFAULT false,
	"email" varchar NOT NULL,
	"email_verified" boolean DEFAULT false NOT NULL,
	"confirmation_code" varchar,
	"password" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"address" varchar NOT NULL,
	"comment" varchar NOT NULL,
	"driver" varchar NOT NULL,
	"order" varchar NOT NULL,
	"restaurant_owner" integer NOT NULL,
	CONSTRAINT "users_table_user_name_unique" UNIQUE("user_name")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "address_table" ADD CONSTRAINT "address_table_user_id_users_table_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "address_table" ADD CONSTRAINT "address_table_city_id_city_table_city_id_fk" FOREIGN KEY ("city_id") REFERENCES "public"."city_table"("city_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "address_table" ADD CONSTRAINT "address_table_city_city_table_city_name_fk" FOREIGN KEY ("city") REFERENCES "public"."city_table"("city_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "address_table" ADD CONSTRAINT "address_table_users_users_table_user_name_fk" FOREIGN KEY ("users") REFERENCES "public"."users_table"("user_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "address_table" ADD CONSTRAINT "address_table_orders_orders_table_order_id_fk" FOREIGN KEY ("orders") REFERENCES "public"."orders_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "category_table" ADD CONSTRAINT "category_table_menu_item_menu_item_table_menu_item_name_fk" FOREIGN KEY ("menu_item") REFERENCES "public"."menu_item_table"("menu_item_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "city_table" ADD CONSTRAINT "city_table_address_restaurant_table_street_address_fk" FOREIGN KEY ("address") REFERENCES "public"."restaurant_table"("street_address") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "city_table" ADD CONSTRAINT "city_table_state_state_table_state_name_fk" FOREIGN KEY ("state") REFERENCES "public"."state_table"("state_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "city_table" ADD CONSTRAINT "city_table_restaurant_restaurant_table_restaurant_name_fk" FOREIGN KEY ("restaurant") REFERENCES "public"."restaurant_table"("restaurant_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "comment_table" ADD CONSTRAINT "comment_table_order_id_orders_table_order_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."orders_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "comment_table" ADD CONSTRAINT "comment_table_user_id_users_table_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "comment_table" ADD CONSTRAINT "comment_table_users_users_table_user_name_fk" FOREIGN KEY ("users") REFERENCES "public"."users_table"("user_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "comment_table" ADD CONSTRAINT "comment_table_orders_orders_table_order_id_fk" FOREIGN KEY ("orders") REFERENCES "public"."orders_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "driver_table" ADD CONSTRAINT "driver_table_user_id_users_table_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "driver_table" ADD CONSTRAINT "driver_table_users_users_table_user_name_fk" FOREIGN KEY ("users") REFERENCES "public"."users_table"("user_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "driver_table" ADD CONSTRAINT "driver_table_orders_orders_table_order_id_fk" FOREIGN KEY ("orders") REFERENCES "public"."orders_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "menu_item_table" ADD CONSTRAINT "menu_item_table_restaurant_id_restaurant_table_restaurant_id_fk" FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurant_table"("restaurant_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "menu_item_table" ADD CONSTRAINT "menu_item_table_category_id_category_table_category_id_fk" FOREIGN KEY ("category_id") REFERENCES "public"."category_table"("category_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "menu_item_table" ADD CONSTRAINT "menu_item_table_restaurant_restaurant_table_restaurant_name_fk" FOREIGN KEY ("restaurant") REFERENCES "public"."restaurant_table"("restaurant_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "menu_item_table" ADD CONSTRAINT "menu_item_table_order_menu_item_order_menu_item_table_order_menu_item_id_fk" FOREIGN KEY ("order_menu_item") REFERENCES "public"."order_menu_item_table"("order_menu_item_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_menu_item_table" ADD CONSTRAINT "order_menu_item_table_order_id_orders_table_order_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."orders_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_menu_item_table" ADD CONSTRAINT "order_menu_item_table_menu_item_id_menu_item_table_menu_item_id_fk" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_item_table"("menu_item_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_menu_item_table" ADD CONSTRAINT "order_menu_item_table_menu_item_menu_item_table_menu_item_name_fk" FOREIGN KEY ("menu_item") REFERENCES "public"."menu_item_table"("menu_item_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_menu_item_table" ADD CONSTRAINT "order_menu_item_table_orders_orders_table_order_id_fk" FOREIGN KEY ("orders") REFERENCES "public"."orders_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_status_table" ADD CONSTRAINT "order_status_table_status_catalog_id_status_catalog_table_status_catalog_id_fk" FOREIGN KEY ("status_catalog_id") REFERENCES "public"."status_catalog_table"("status_catalog_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_status_table" ADD CONSTRAINT "order_status_table_order_orders_table_order_id_fk" FOREIGN KEY ("order") REFERENCES "public"."orders_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_status_table" ADD CONSTRAINT "order_status_table_status_catalog_status_catalog_table_status_name_fk" FOREIGN KEY ("status_catalog") REFERENCES "public"."status_catalog_table"("status_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_restaurant_id_restaurant_table_restaurant_id_fk" FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurant_table"("restaurant_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_delivery_address_id_address_table_address_id_fk" FOREIGN KEY ("delivery_address_id") REFERENCES "public"."address_table"("address_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_user_id_users_table_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_driver_id_driver_table_driver_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."driver_table"("driver_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_comments_comment_table_comment_id_fk" FOREIGN KEY ("comments") REFERENCES "public"."comment_table"("comment_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_order_menu_item_order_menu_item_table_order_menu_item_id_fk" FOREIGN KEY ("order_menu_item") REFERENCES "public"."order_menu_item_table"("order_menu_item_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_order_status_order_status_table_order_status_id_fk" FOREIGN KEY ("order_status") REFERENCES "public"."order_status_table"("order_status_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_address_address_table_address_id_fk" FOREIGN KEY ("address") REFERENCES "public"."address_table"("address_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_driver_driver_table_driver_id_fk" FOREIGN KEY ("driver") REFERENCES "public"."driver_table"("driver_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_restaurant_restaurant_table_restaurant_name_fk" FOREIGN KEY ("restaurant") REFERENCES "public"."restaurant_table"("restaurant_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders_table" ADD CONSTRAINT "orders_table_users_users_table_user_name_fk" FOREIGN KEY ("users") REFERENCES "public"."users_table"("user_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "restaurant_owner_table" ADD CONSTRAINT "restaurant_owner_table_restaurant_id_restaurant_table_restaurant_id_fk" FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurant_table"("restaurant_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "restaurant_owner_table" ADD CONSTRAINT "restaurant_owner_table_users_users_table_user_id_fk" FOREIGN KEY ("users") REFERENCES "public"."users_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "restaurant_owner_table" ADD CONSTRAINT "restaurant_owner_table_restaurant_restaurant_table_restaurant_name_fk" FOREIGN KEY ("restaurant") REFERENCES "public"."restaurant_table"("restaurant_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "state_table" ADD CONSTRAINT "state_table_city_city_table_city_name_fk" FOREIGN KEY ("city") REFERENCES "public"."city_table"("city_name") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "status_catalog_table" ADD CONSTRAINT "status_catalog_table_order_status_order_status_table_order_status_id_fk" FOREIGN KEY ("order_status") REFERENCES "public"."order_status_table"("order_status_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "users_table" ADD CONSTRAINT "users_table_comment_comment_table_comment_text_fk" FOREIGN KEY ("comment") REFERENCES "public"."comment_table"("comment_text") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "users_table" ADD CONSTRAINT "users_table_restaurant_owner_restaurant_owner_table_restaurant_owner_id_fk" FOREIGN KEY ("restaurant_owner") REFERENCES "public"."restaurant_owner_table"("restaurant_owner_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
