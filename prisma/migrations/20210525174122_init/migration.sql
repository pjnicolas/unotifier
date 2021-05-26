-- CreateTable
CREATE TABLE "Token" (
    "id" SERIAL NOT NULL,
    "hash" TEXT NOT NULL,
    "chatId" TEXT NOT NULL,
    "cdate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Token.hash_unique" ON "Token"("hash");
