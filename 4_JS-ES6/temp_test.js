const fetchParallel = async () => {

    try {
        const p1 = fetch('https://jsonplaceholder.typicode.com/todos/1');
        const p2 = fetch('https://jsonplaceholder.typicode.com/todos/2')
        const resp1 = await p1;
        const resp2 = await p2;

        if (!resp1.ok) {
            throw new Error('failed')
        }
        if (!resp2.ok) {
            throw new Error('failed')
        }
        const result1=await resp1.json()
        const result2=await resp2.json()
        return { result1, result2 };
    } catch (err) {
        throw err;
    }
}
fetchParallel().then(res => {
    console.log(res)
}).catch(err => {
    console.log(err)
})