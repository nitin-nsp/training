
//  1
const multiplyWithCallback = (a, b, cb) => {

    return cb(a * b);

}
const print = (...a) => {
    console.log(a);
}

multiplyWithCallback(2, 3, print);





// 2
const doAsyncOperation = async (cb) => {
    setTimeout(() => {
        cb("sucess ")
    }, 2);
}
doAsyncOperation(print)

// 3
const promiseEx = (delay) => {
    return new Promise(
        (resolve, reject) => {
            setTimeout(() => {
                resolve(`Resolved after ${delay}`);
            }, delay)

        }
    )
}
promiseEx(3).then((data) => {
    print(data)
})

// 4
const fetchData = async (url) => {
    return new Promise((resolve, reject) => {
        fetch(url)
            .then(async (res) => {
                if (res.ok) {
                    const result = await res.json();
                    resolve(result);
                }
            })
            .catch(err => {
                reject(err);
            });
    });
};
fetchData('https://jsonplaceholder.typicode.com/todos').then(res => {
    console.log(res)
}).catch(err => {
    print(err)
})

// 5
const fetchData2 = async (url) => {
    try {
        const res = await fetch(url);
        return await res.json()

    } catch (err) {
        throw new Error(err.message)
    }
}


// 6

const fetchAndPerformSeq = async () => {
    try {
        // t1
        const url1 = 'https://jsonplaceholder.typicode.com/todos/1';
        const resp = await fetch(url1);
        if (!resp.ok) {
            throw new Error('Failed')
        }
        const d1 = resp.json();

        //  t2
        const processData = d1.map(item => {
            return {
                todoTitle: item.title,
                todoStatus: item.completed

            }
        })

        // t3
        const url2 = "url2";
        const resp2 = await fetch(url2, {
            method: 'POST'
        });
        if (!resp2.ok) {
            throw new Error('Failed')
        }

        const data = resp2.json();

    } catch (error) {
        throw error
    }
}
fetchAndPerformSeq().then(res => {
    console.log('data =>', res)
}).catch(err => {
    console.log(err)
})


// 7

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
        return { resp1, resp2 };
    } catch (err) {
        throw err;
    }
}
fetchParallel().then(res => {
    console.log(res)
}).catch(err => {
    console.log(err)
})


const singleArr = [1, 2, 3, 4, 5];
const doubleArr = singleArr.map(element => {
    return 2 * element
})

doubleArr.forEach((ele, i) => {
    print(i, ele)
})
const grtArr = [5, 8, 15, 3, 2]
const ch1 = grtArr.every((ele) => {
    return ele <= 10;
})
print(ch1);
