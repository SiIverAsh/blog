-- CreateTable
CREATE TABLE "Post" (
    "id" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "last_modified_at" TIMESTAMP(3),
    "content" TEXT NOT NULL,
    "htmlContent" TEXT NOT NULL,
    "excerpt" TEXT NOT NULL,
    "subject" TEXT,
    "categories" JSONB NOT NULL DEFAULT '[]',
    "tags" JSONB NOT NULL DEFAULT '[]',
    "layout" TEXT NOT NULL DEFAULT 'post',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Recommendation" (
    "id" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "tech" JSONB NOT NULL,
    "paper" JSONB NOT NULL,
    "llm" JSONB NOT NULL,
    "algorithm" JSONB NOT NULL,
    "new_project" JSONB NOT NULL,
    "history" JSONB NOT NULL,
    "cv_recommend" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Recommendation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HistoryLog" (
    "id" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "titles" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "HistoryLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MeInfo" (
    "id" INTEGER NOT NULL DEFAULT 1,
    "content" JSONB NOT NULL,

    CONSTRAINT "MeInfo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Post_slug_key" ON "Post"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Recommendation_date_key" ON "Recommendation"("date");

-- CreateIndex
CREATE UNIQUE INDEX "HistoryLog_date_key" ON "HistoryLog"("date");
