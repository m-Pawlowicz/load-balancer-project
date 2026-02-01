const https = require("https");
const fs = require("fs");

const createServer = () => {
  let counter = 0;

  const options = {
    key: fs.readFileSync(`/tmp/${process.env.NODE_ID}.key`),
    cert: fs.readFileSync(`/tmp/${process.env.NODE_ID}.crt`),
  };

  return https.createServer(options, (req, res) => {
    counter++;

    const nodeId = process.env.NODE_ID || "unknown";

    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(
      JSON.stringify({
        counter: counter,
        nodeId: nodeId,
      }),
    );
  });
};

const server = createServer();
const PORT = process.env.PORT || 443;

server.listen(PORT, () => {
  console.log(
    `Server running on port ${PORT}, NODE_ID: ${process.env.NODE_ID || "unknown"}`,
  );
});
