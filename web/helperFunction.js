async function waitForTensorFlow() {
    if (!window.tf) {
        throw new Error('TensorFlow.js is not loaded');
    }
    
    try {
        // Load your model here
        window.model = await tf.loadLayersModel('assets/models/classification.json');
        console.log('Model loaded successfully');
    } catch (error) {
        console.error('Error loading model:', error);
        throw error;
    }
}

// // Preprocess image and make prediction
// async function predictImage(img) {
//     // Convert image to tensor
//     const tensor = tf.browser.fromPixels(img)
//         .resizeNearestNeighbor([224, 224]) // Resize to match your model's input size
//         .toFloat()
//         .expandDims(0);
    
//     // Normalize the image
//     const normalized = tensor.div(255.0);
    
//     // Make prediction
//     const prediction = await window.model.predict(normalized).data();
//     console.log('Prediction array:', prediction);
    
    
//     // Cleanup
//     tensor.dispose();
//     normalized.dispose();
    
//     return prediction;
    
// }

// async function predictImage(img) {
//     try {
//         const tensor = tf.browser.fromPixels(img)
//             .resizeNearestNeighbor([225, 225])
//             .toFloat()
//             .expandDims(0);

//         const normalized = tensor.div(255.0);
//         const predictionTensor = await window.model.predict(normalized);
//         const prediction = Array.from(await predictionTensor.data()); // Ensure it's a plain array
//         console.log('Prediction:', prediction);

//         tensor.dispose();
//         normalized.dispose();
//         predictionTensor.dispose();

//         return prediction; // Return as a plain array
//     } catch (error) {
//         console.error('Error during prediction:', error);
//         throw error;
//     }
// }

// // Get the index of the highest probability
// function getTopPrediction(prediction) {
//     // return prediction.indexOf(Math.max(...prediction));

//     if (!Array.isArray(prediction)) {
//         console.error('Invalid prediction: Expected an array');
//         throw new Error('Invalid prediction');
//     }
//     return prediction.indexOf(Math.max(...prediction));
// }
// window.waitForTensorFlow = waitForTensorFlow;

// 3333333333333333333333333333333333333333333333333333

// let model = null;

// // Wait for TensorFlow.js and model to load
// async function waitForTensorFlow() {
//     if (!window.tf) {
//         throw new Error('TensorFlow.js is not loaded');
//     }
    
//     try {
//         // Load your model
//         model = await tf.loadLayersModel('assets/models/classification.json');
//         console.log('Model loaded successfully');
//     } catch (error) {
//         console.error('Error loading model:', error);
//         throw error;
//     }
// }

// // Preprocess image and make prediction
// async function predictImage(img) {
//     // Convert image to tensor
//     const tensor = tf.browser.fromPixels(img)
//         .resizeNearestNeighbor([224, 224]) // adjust size to match your model's input
//         .toFloat()
//         .expandDims();
    
//     // Normalize the image
//     const normalized = tensor.div(255.0);
    
//     // Make prediction
//     const predictions = await model.predict(normalized).data();
    
//     // Cleanup
//     tensor.dispose();
//     normalized.dispose();
    
//     // Convert to regular array and return
//     return Array.from(predictions);
// }