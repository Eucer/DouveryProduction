const mongoose = require('mongoose');



const viewedSchema = mongoose.Schema({
    userId: {
        type: String,
        required: true,
    },
    viewed: {
        type:Number,
        required: true,
    }
});


module.exports = viewedSchema;