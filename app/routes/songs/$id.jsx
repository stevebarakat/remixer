import { json } from "@remix-run/node";
import { db } from "~/utils/db.server";

export const loader = async ({ params: { id } }) => {
  const song = await db.song.findUnique({
    where: { id: id },
    include: { tracks: true },
  });
  if (!song) throw new Error("Song not found");
  const data = { song };
  return json(data);
};
