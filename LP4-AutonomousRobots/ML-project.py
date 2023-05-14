import os
from keras.preprocessing.image import ImageDataGenerator

# Define the directory containing the PNG images
image_dir = './kiwi-detection/1'

# Create an ImageDataGenerator object to preprocess the images
data_generator = ImageDataGenerator(rescale=1./255)

# Load the images from the directory and preprocess them
image_data = data_generator.flow_from_directory(
    image_dir,
    target_size=(224, 224),  # Resize the images to a fixed size
    batch_size=32,
    class_mode='categorical'  # Specify the type of labels
)

class 
BASE_PATH = "kiwi-detection"
IMAGES_PATH = os.path.sep.join([BASE_PATH/1, "images"])
ANNOTS_PATH = os.path.sep.join([BASE_PATH, "airplanes.csv"])