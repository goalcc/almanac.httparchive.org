let { generate_chapters } = require('./generate_chapters');

(async () => {
  const first_arg = process.argv.slice(2)[0]
  await generate_chapters(first_arg);
})();
