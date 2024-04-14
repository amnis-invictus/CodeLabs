function debounce(fn, delay) {
  let timeout;
  return function () {
    if (timeout) clearTimeout(timeout);
    timeout = setTimeout(() => { timeout = null; fn.apply(this, arguments); }, delay);
  };
}
