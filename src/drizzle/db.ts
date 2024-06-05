import "dotenv/config";

import {drizzle} from "drizzle-orm/node-postgres";
import {Client} from "pg";
import * as schema from "./schema";

export  const client = new Client({
  connectionString: process.env.DB_URL as string,
});

const main = async () => {
  await client.connect(); // connect to the database
//   await drizzle(client).migrate(schema); //
//   await client.end();
}

main()
// main().catch(console.error);

const db = drizzle(client, {schema , logger: true});
export default db;