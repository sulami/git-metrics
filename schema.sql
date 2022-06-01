DROP TABLE IF EXISTS stats;
CREATE TABLE stats (
  "sha" TEXT,
  "timestamp" TIMESTAMP,
  "author" TEXT,
  "subject" TEXT,
  "service" TEXT,
  "changed" INTEGER,
  "inserts" INTEGER,
  "deletes" INTEGER
);
