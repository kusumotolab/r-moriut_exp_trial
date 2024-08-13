# ベースイメージとして公式のNode.jsイメージを使用
FROM node:18-slim

# 作業ディレクトリを指定
WORKDIR /app

# 必要なパッケージをインストール（vim，gitのインストール）
RUN apt-get update \
    && apt-get install -y \
    vim \
    git \
    && rm -rf /var/lib/apt/lists/*

# ローカルのアーカイブファイルをコンテナ内に追加し，展開
ADD src.tar.gz .

# ローカルのpackage.jsonをコンテナ内にコピー
COPY package.json .

# アプリケーションの依存関係をインストール
RUN npm install

# コンテナがリッスンするポートを指定
EXPOSE 3000

# コンテナ起動時に実行されるコマンドを指定
CMD ["node", "src/index.js"]