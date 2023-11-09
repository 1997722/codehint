document.addEventListener('DOMContentLoaded', () => {
  const likeCheckboxes = document.querySelectorAll('.like-checkbox');

  likeCheckboxes.forEach((checkbox) => {
    checkbox.addEventListener('change', async (event) => {
      const postId = checkbox.id.replace('like', '');
      const likeButton = document.querySelector(`.like-button[for=like${postId}]`);

      if (event.target.checked) {
        try {
          const response = await fetch(checkbox.dataset.turboActionValue, {
            method: checkbox.dataset.turboMethod,
          });

          if (!response.ok) {
            throw new Error('Network response was not ok');
          }

          likeButton.classList.add('liked');
        } catch (error) {
          console.error('Error:', error);
          event.target.checked = false;
        }
      } else {
        try {
          const response = await fetch(checkbox.dataset.turboActionValue, {
            method: checkbox.dataset.turboMethod,
          });

          if (!response.ok) {
            throw new Error('Network response was not ok');
          }

          likeButton.classList.remove('liked');
        } catch (error) {
          console.error('Error:', error);
          event.target.checked = true;
        }
      }
    });
  });
});
