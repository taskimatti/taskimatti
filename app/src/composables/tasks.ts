import { useDirectus } from '~/composables/directus';

export const complete = async (partial_task_object: Task) => {
  const { $directus } = useDirectus();
  // copy the object
  const _partial_task_object = { ...partial_task_object };
  delete _partial_task_object.id;
  delete _partial_task_object.completed;
  delete _partial_task_object.project;
  delete _partial_task_object.title;
  delete _partial_task_object.points;
  delete _partial_task_object.desc;
  delete _partial_task_object.type;
  delete _partial_task_object.image;
  // const response: Record<string, any> = await $directus.request(updateItem('Task', uuid, partial_task_object));
  const response = await fetch($directus.url.href + 'items/Tasks/' + partial_task_object.id + '?fields=id', {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + localStorage.getItem('access_token'),
    },
    body: JSON.stringify(_partial_task_object),
  });

  const result = await response.json();

  return result;
};
