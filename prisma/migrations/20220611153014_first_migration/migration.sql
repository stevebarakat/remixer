-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "username" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "SongMix" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" TEXT NOT NULL,
    "masterVolume" REAL NOT NULL,
    "busOneVolume" REAL NOT NULL,
    "busTwoVolume" REAL NOT NULL,
    CONSTRAINT "SongMix_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TrackMix" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "trackMixId" INTEGER NOT NULL,
    "trackVolume" REAL DEFAULT 0,
    "trackPan" REAL DEFAULT 0,
    "trackEqHi" REAL DEFAULT 0,
    "trackEqMid" REAL DEFAULT 0,
    "trackEqLow" REAL DEFAULT 0,
    CONSTRAINT "TrackMix_trackMixId_fkey" FOREIGN KEY ("trackMixId") REFERENCES "Track" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Track" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "songId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "volume" REAL DEFAULT 0,
    "pan" REAL DEFAULT 0,
    "busOne" BOOLEAN DEFAULT false,
    CONSTRAINT "Track_songId_fkey" FOREIGN KEY ("songId") REFERENCES "Song" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Song" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "artist" TEXT NOT NULL,
    "year" TEXT NOT NULL,
    "studio" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "bpm" INTEGER,
    "start" INTEGER NOT NULL,
    "end" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_SongMixToTrackMix" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_SongMixToTrackMix_A_fkey" FOREIGN KEY ("A") REFERENCES "SongMix" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_SongMixToTrackMix_B_fkey" FOREIGN KEY ("B") REFERENCES "TrackMix" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "SongMix_userId_key" ON "SongMix"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "_SongMixToTrackMix_AB_unique" ON "_SongMixToTrackMix"("A", "B");

-- CreateIndex
CREATE INDEX "_SongMixToTrackMix_B_index" ON "_SongMixToTrackMix"("B");
