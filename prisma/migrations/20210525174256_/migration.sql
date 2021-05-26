/*
  Warnings:

  - You are about to drop the column `hashx` on the `Token` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[code]` on the table `Token` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `code` to the `Token` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Token.hashx_unique";

-- AlterTable
ALTER TABLE "Token" DROP COLUMN "hashx",
ADD COLUMN     "code" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Token.code_unique" ON "Token"("code");
