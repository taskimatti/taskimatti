import {useDirectus} from "~/composables/directus";

export const complete = async (uuid: string) => {
    const { $directus } = useDirectus();
    const response = await fetch($directus.url.href + 'items/Tasks/' + uuid, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            Authorization: 'Bearer ' + localStorage.getItem('access_token'),
        },
    });
    console.log(response.body);
};
