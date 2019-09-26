#standardSQL
# 14_13: Distribution of image stats
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(reqImg, 1000)[OFFSET(percentile * 10)] AS image_count,
  ROUND(APPROX_QUANTILES(bytesImg, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS image_kbytes
FROM
  `httparchive.summary_pages.2019_07_01_*`
JOIN
  `httparchive.technologies.2019_07_01_*`
USING (_TABLE_SUFFIX, url),
UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  category = 'CMS'
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client