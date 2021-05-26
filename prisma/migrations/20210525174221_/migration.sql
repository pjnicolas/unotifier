/*
  Warnings:

  - You are about to drop the column `hash` on the `Token` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[hashx]` on the table `Token` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `hashx` to the `Token` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Token.hash_unique";

-- AlterTable
ALTER TABLE "Token" DROP COLUMN "hash",
ADD COLUMN     "hashx" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Token.hashx_unique" ON "Token"("hashx");
