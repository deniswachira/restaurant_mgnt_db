import { pgTable, integer, text, boolean, decimal, timestamp, varchar } from "drizzle-orm/pg-core";

// restaurant table
export const restaurant_table = pgTable("restaurant_table", {
    restaurant_id: integer("restaurant_id").primaryKey(),
    restaurant_name: text("restaurant_name").notNull().unique(),
    street_address: varchar("street_address").notNull().unique(),
    zip_code: varchar("zip_code").notNull(),
    city_id: integer("city_id").notNull(),
    created_at: timestamp("created_at").notNull().defaultNow(),
    updated_at: timestamp("updated_at").notNull().defaultNow(),
    menu_items: text("menu_items").notNull(),
    orders: text("orders").notNull(),
    city: text("city").notNull(),
    restaurant_owner: text("restaurant_owner").notNull(),
});

// menu_item table
export const menu_item_table: any = pgTable("menu_item_table", {
    menu_item_id: integer("menu_item_id").primaryKey(),
    menu_item_name: text("menu_item_name").notNull().unique(),
    restaurant_id: integer("restaurant_id").notNull().references(() => restaurant_table.restaurant_id, { onDelete: 'cascade' }),
    category_id: integer("category_id").notNull().references(() => category_table.category_id, { onDelete: 'cascade' }),
    description: text("description").notNull(),
    ingredients: text("ingredients").notNull(),
    price: decimal("price").notNull(),
    active: boolean("active").notNull(),
    created_at: timestamp("created_at").defaultNow(),
    updated_at: timestamp("updated_at").defaultNow(),
    restaurant: varchar("restaurant").notNull().references(() => restaurant_table.restaurant_name, { onDelete: 'cascade' }),
    order_menu_item: integer("order_menu_item").notNull().references(() => order_menu_item_table.order_menu_item_id, { onDelete: 'cascade' }),
});

// category table
export const category_table: any = pgTable("category_table", {
    category_id: integer("category_id").primaryKey(),
    category_name: text("category_name").notNull(),
    menu_item: varchar("menu_item").notNull().references(() => menu_item_table.menu_item_name, { onDelete: 'cascade' }),
});

// state table
export const state_table: any = pgTable("state_table", {
    state_id: integer("state_id").primaryKey(),
    state_name: text("state_name").notNull().unique(),
    code: text("code").notNull(),
    city: varchar("city").notNull().references(() => city_table.city_name, { onDelete: 'cascade' }),
});

// city table
export const city_table: any = pgTable("city_table", {
    city_id: integer("city_id").primaryKey(),
    city_name: text("city_name").notNull().unique(),
    state_id: integer("state_id").notNull(),
    address: varchar("address").notNull().references(() => restaurant_table.street_address, { onDelete: 'cascade' }),
    state: varchar("state").notNull().references(() => state_table.state_name, { onDelete: 'cascade' }),
    restaurant: varchar("restaurant").notNull().references(() => restaurant_table.restaurant_name, { onDelete: 'cascade' }),
});

// restaurant_owner table
export const restaurant_owner_table: any = pgTable("restaurant_owner_table", {
    restaurant_owner_id: integer("restaurant_owner_id").primaryKey(),
    restaurant_id: integer("restaurant_id").notNull().references(() => restaurant_table.restaurant_id, { onDelete: 'cascade' }),
    owner_id: integer("owner_id").notNull(),
    users: integer("users").notNull().references(() => users_table.user_id, { onDelete: 'cascade' }),
    restaurant: varchar("restaurant").notNull().references(() => restaurant_table.restaurant_name, { onDelete: 'cascade' }),
});

// users table
export const users_table: any = pgTable("users_table", {
    user_id: integer("user_id").primaryKey(),
    user_name: varchar("user_name").notNull().unique(),
    contact_phone: varchar("contact_phone").notNull(),
    phone_verified: boolean("phone_verified").default(false),
    email: varchar("email").notNull(),
    email_verified: boolean("email_verified").notNull().default(false),
    confirmation_code: varchar("confirmation_code"),
    password: varchar("password").notNull(),
    created_at: timestamp("created_at").notNull().defaultNow(),
    updated_at: timestamp("updated_at").notNull().defaultNow(),
    address: varchar("address").notNull(),
    comment: varchar("comment").notNull().references(() => comment_table.comment_text, { onDelete: 'cascade' }),
    driver: varchar("driver").notNull(),
    order: varchar("order").notNull(),
    restaurant_owner: integer("restaurant_owner").notNull().references(() => restaurant_owner_table.restaurant_owner_id, { onDelete: 'cascade' }),
});

// address table
export const address_table = pgTable("address_table", {
    address_id: integer("address_id").primaryKey(),
    street_address_1: varchar("street_address_1").notNull(),
    street_address_2: varchar("street_address_2"),
    zip_code: varchar("zip_code").notNull(),
    delivery_instructions: varchar("delivery_instructions"),
    user_id: integer("user_id").notNull().references(() => users_table.user_id, { onDelete: 'cascade' }),
    city_id: integer("city_id").notNull().references(() => city_table.city_id, { onDelete: 'cascade' }),
    created_at: timestamp("created_at").notNull().defaultNow(),
    updated_at: timestamp("updated_at").notNull().defaultNow(),
    city: varchar("city").notNull().references(() => city_table.city_name, { onDelete: 'cascade' }),
    users: varchar("users").notNull().references(() => users_table.user_name, { onDelete: 'cascade' }),
    orders: integer("orders").notNull().references(() => orders_table.order_id, { onDelete: 'cascade' }),
});

// driver table
export const driver_table = pgTable("driver_table", {
    driver_id: integer("driver_id").primaryKey(),
    vehicle_make: varchar("vehicle_make").notNull(),
    vehicle_model: varchar("vehicle_model").notNull(),
    vehicle_year: varchar("vehicle_year").notNull(),
    user_id: integer("user_id").notNull().references(() => users_table.user_id, { onDelete: 'cascade' }),
    online: boolean("online").notNull(),
    delivering: boolean("delivering").notNull(),
    created_at: timestamp("created_at").notNull().defaultNow(),
    updated_at: timestamp("updated_at").notNull().defaultNow(),
    users: varchar("users").notNull().references(() => users_table.user_name, { onDelete: 'cascade' }),
    orders: integer("orders").notNull().references(() => orders_table.order_id, { onDelete: 'cascade' }),
});

// comments table
export const comment_table : any = pgTable("comment_table", {
    comment_id: integer("comment_id").primaryKey(),
    order_id: integer("order_id").notNull().references(() => orders_table.order_id, { onDelete: 'cascade' }),
    user_id: integer("user_id").notNull().references(() => users_table.user_id, { onDelete: 'cascade' }),
    comment_text: varchar("comment_text").notNull().unique(),
    is_complaint: boolean("is_complaint").notNull(),
    is_praise: boolean("is_praise").notNull(),
    created_at: timestamp("created_at").notNull().defaultNow(),
    updated_at: timestamp("updated_at").notNull().defaultNow(),
    users: varchar("users").notNull().references(() => users_table.user_name, { onDelete: 'cascade' }),
    orders: integer("orders").notNull().references(() => orders_table.order_id, { onDelete: 'cascade' }),
});

// orders table
export const orders_table: any = pgTable("orders_table", {
    order_id: integer("order_id").primaryKey(),
    restaurant_id: integer("restaurant_id").notNull().references(() => restaurant_table.restaurant_id, { onDelete: 'cascade' }),
    estimated_delivery_time: timestamp("estimated_delivery_time").notNull(),
    actual_delivery_time: timestamp("actual_delivery_time").notNull(),
    delivery_address_id: integer("delivery_address_id").notNull().references(() => address_table.address_id, { onDelete: 'cascade' }),
    user_id: integer("user_id").notNull().references(() => users_table.user_id, { onDelete: 'cascade' }),
    driver_id: integer("driver_id").notNull().references(() => driver_table.driver_id, { onDelete: 'cascade' }),
    price: decimal("price").notNull(),
    discount: decimal("discount").notNull(),
    final_price: decimal("final_price").notNull(),
    comment: varchar("comment"),
    created_at: timestamp("created_at").notNull().defaultNow(),
    updated_at: timestamp("updated_at").notNull().defaultNow(),
    comments: integer("comments").notNull().references(() => comment_table.comment_id, { onDelete: 'cascade' }),
    order_menu_item: integer("order_menu_item").notNull().references(() => order_menu_item_table.order_menu_item_id, { onDelete: 'cascade' }),
    order_status: integer("order_status").notNull().references(() => order_status_table.order_status_id, { onDelete: 'cascade' }),
    address: integer("address").notNull().references(() => address_table.address_id, { onDelete: 'cascade' }),
    driver: integer("driver").notNull().references(() => driver_table.driver_id, { onDelete: 'cascade' }),
    restaurant: varchar("restaurant").notNull().references(() => restaurant_table.restaurant_name, { onDelete: 'cascade' }),
    users: varchar("users").notNull().references(() => users_table.user_name, { onDelete: 'cascade' }),
});

// order_status table
export const order_status_table = pgTable("order_status_table", {
    order_status_id: integer("order_status_id").primaryKey(),
    status_catalog_id: integer("status_catalog_id").notNull().references(() => status_catalog_table.status_catalog_id, { onDelete: 'cascade' }),
    created_at: timestamp("created_at").notNull().defaultNow(),
    order: integer("order").notNull().references(() => orders_table.order_id, { onDelete: 'cascade' }),
    status_catalog: varchar("status_catalog").notNull().references(() => status_catalog_table.status_name, { onDelete: 'cascade' }),
});

// status_catalog table
export const status_catalog_table:any = pgTable("status_catalog_table", {
    status_catalog_id: integer("status_catalog_id").primaryKey(),
    status_name: varchar("status_name").notNull().unique(),
    order_status: integer("order_status").notNull().references(() => order_status_table.order_status_id, { onDelete: 'cascade' }),
});

// order_menu_item table
export const order_menu_item_table = pgTable("order_menu_item_table", {
    order_menu_item_id: integer("order_menu_item_id").primaryKey(),
    order_id: integer("order_id").notNull().references(() => orders_table.order_id, { onDelete: 'cascade' }),
    menu_item_id: integer("menu_item_id").notNull().references(() => menu_item_table.menu_item_id, { onDelete: 'cascade' }),
    quantity: integer("quantity").notNull(),
    item_price: decimal("item_price").notNull(),
    price: decimal("price").notNull(),
    comment: varchar("comment"),
    menu_item: varchar("menu_item").notNull().references(() => menu_item_table.menu_item_name, { onDelete: 'cascade' }),
    orders: integer("orders").notNull().references(() => orders_table.order_id, { onDelete: 'cascade' }),
});


//relationship between restaurant and menu_item











//types inferred from the schema
export type TRestaurant = typeof restaurant_table.$inferInsert;
export type TMenuItem = typeof menu_item_table.$inferInsert;
export type TCategory = typeof category_table.$inferInsert;
export type TOrderMenuItem = typeof order_menu_item_table.$inferInsert;
export type TState = typeof state_table.$inferInsert;
export type TCity = typeof city_table.$inferInsert;
export type TRestaurantOwner = typeof restaurant_owner_table.$inferInsert;
export type TUsers = typeof users_table.$inferInsert;
export type TAddress = typeof address_table.$inferInsert;
export type TDriver = typeof driver_table.$inferInsert;
export type TComment = typeof comment_table.$inferInsert;
export type TOrders = typeof orders_table.$inferInsert;
export type TOrderStatus = typeof order_status_table.$inferInsert;
export type TStatusCatalog = typeof status_catalog_table.$inferInsert;
export type TRestaurantSelect = typeof restaurant_table.$inferSelect;
export type TMenuItemSelect = typeof menu_item_table.$inferSelect;
export type TCategorySelect = typeof category_table.$inferSelect;
export type TOrderMenuItemSelect = typeof order_menu_item_table.$inferSelect;
export type TStateSelect = typeof state_table.$inferSelect;
export type TCitySelect = typeof city_table.$inferSelect;
export type TRestaurantOwnerSelect = typeof restaurant_owner_table.$inferSelect;
export type TUsersSelect = typeof users_table.$inferSelect;
export type TAddressSelect = typeof address_table.$inferSelect;
export type TDriverSelect = typeof driver_table.$inferSelect;
export type TCommentSelect = typeof comment_table.$inferSelect;
export type TOrdersSelect = typeof orders_table.$inferSelect;
export type TOrderStatusSelect = typeof order_status_table.$inferSelect;
export type TStatusCatalogSelect = typeof status_catalog_table.$inferSelect;


