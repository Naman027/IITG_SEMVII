import torch
import torch.nn as nn
import torch.nn.functional as F
import numpy as np
from sklearn import datasets
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split

# Class for 2-class logistic regression
class Model(nn.Module):
    def _init_(self, n_input_features):
        super(Model, self)._init_()
        self.linear = nn.Linear(n_input_features, 1)

    def forward(self, x):
        y_pred = torch.sigmoid(self.linear(x))
        return y_pred

def train_loop(X_train, y_train, model, criterion, optimizer, num_epochs):
    for epoch in range(num_epochs):
        # Forward pass and loss
        y_pred = model(X_train)
        loss = criterion(y_pred, y_train)
        # Backward pass and update
        loss.backward()
        optimizer.step()
        # zero grad before new step
        optimizer.zero_grad()
        if (epoch+1) % 100 == 0:
            print(f'epoch: {epoch+1}, loss = {loss.item():.4f}'.format())

def get_accuracy(X_test, y_test, model):
    with torch.no_grad():
        y_predicted = model(X_test)
        _,y_predicted_cls = torch.max(y_predicted.data, 1)
        acc = y_predicted_cls.eq(y_test).sum() / float(y_test.shape[0])
        print(" Accuracy")
        print(f'accuracy: {acc.item():.4f}')

def normalize(X,y):
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 3)
    # Scale the input features
    sc = StandardScaler()
    X_train = sc.fit_transform(X_train)
    X_test = sc.transform(X_test)
    # Get the torch tensors
    X_train = torch.from_numpy(X_train.astype(np.float32))
    X_test = torch.from_numpy(X_test.astype(np.float32))
    y_train = torch.from_numpy(y_train.astype(np.float32)).long()
    y_test = torch.from_numpy(y_test.astype(np.float32)).long()
    return X_train, X_test, y_train, y_test

def logistic_regression(X, y, num_epochs, learning_rate):
    n_samples, n_features = X.shape
    X_train, X_test, y_train, y_test = normalize(X,y)
    y_train = y_train.view(y_train.shape[0], 1).type(torch.FloatTensor)
    y_test = y_test.view(y_test.shape[0], 1).type(torch.FloatTensor)
    # 1) Create the model
    model = Model(n_features)
    # 2) Loss and optimizer
    criterion = nn.BCELoss()
    optimizer = torch.optim.SGD(model.parameters(), lr=learning_rate)
    # 3) Training loop
    train_loop(X_train, y_train, model, criterion, optimizer, num_epochs)
    # 4) Evaluation
    correct,total = 0,0
    confusion_matrix = np.zeros((2,2))

    with torch.no_grad():
        y_predicted = model(X_test)
        y_predicted_cls = y_predicted.round()
        acc = y_predicted_cls.eq(y_test).sum() / float(y_test.shape[0])
        for i in range(y_predicted_cls.shape[0]):
            confusion_matrix[1 - int(y_test[i].item())][1-int(y_predicted_cls[i].item())]+=1
        print("Accuracy")
        print(f'accuracy: {acc.item():.4f}')
    
    # Cost Matrix for confusion matrix
    cost_matrix = np.array([[0,5],[1,0]])
    print("Confusion Matrix")
    print(confusion_matrix)
    print("Cost Matrix")
    print(cost_matrix)
    print("Cost")
    # Get the cost form the confusion matrix
    cost = np.sum(confusion_matrix*cost_matrix)
    print(f'cost: {cost.item():.4f}')

# Load breast cancer dataset
bc = datasets.load_breast_cancer()

print("Breast cancer dataset")
logistic_regression(bc.data, bc.target, num_epochs = 1000, learning_rate = 0.01)
