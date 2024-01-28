import { useDirectus } from '~/composables/directus';

export const complete = async (partial_task_object: Task) => {
  const { $directus } = useDirectus();
  // const response: Record<string, any> = await $directus.request(updateItem('Task', uuid, partial_task_object));
  const response = await fetch($directus.url.href + 'items/Tasks/' + partial_task_object.id + '?fields=*.*.*', {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + localStorage.getItem('access_token'),
    },
    body: JSON.stringify(partial_task_object),
  });

  const result = await response.json();

  // should return the updated task
  console.log(result.data);
};
