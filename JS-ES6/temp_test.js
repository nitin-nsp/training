const fetchData = async (url) => {
    return new Promise((resolve, reject) => {
        fetch(url)
            .then(async(res) => {
                if (res.ok) {
                    const result=await res.json();
                    resolve(result);
                } 
            })
            .catch(err => {
                reject(err);
            });
    });
};

fetchData('https://jsonplaceholder.typicode.com/todos')
    .then(res => {
        console.log("resolve=> ",res);
    })
    .catch(err => {
        console.error(err);
    });
