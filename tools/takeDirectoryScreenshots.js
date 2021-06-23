const Pageres = require('pageres');

(async () => {
	await new Pageres({delay: 2})
		.src('https://accent-technologies.com/', ['570x335'], {crop: true})
		.dest(__dirname)
		.run();

	console.log('Finished generating screenshots!');
})();