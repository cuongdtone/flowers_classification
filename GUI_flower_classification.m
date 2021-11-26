function varargout = GUI_flower_classification(varargin)
addpath(genpath('.\ultis'));
addpath(genpath('.\models'));
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @GUI_flower_classification_OpeningFcn, ...
                       'gui_OutputFcn',  @GUI_flower_classification_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_flower_classification is made visible.
function GUI_flower_classification_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

function varargout = GUI_flower_classification_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

function load_test_data_Callback(hObject, eventdata, handles)
    addpath(genpath('.\ultis')); %
    addpath(genpath('.\models')); %
    global path files idx;
    path = uigetdir;
    files = dir([path, '\*.jpg']);
    idx = 1;
    set(handles.result, 'String','Loading ...');
    drawnow;

    set(handles.number_image, 'String',[num2str(idx), '/', num2str(length(files))]);
    image = imread([path, '\',files(idx).name]);
    axes(handles.axes1);
    imshow(image);
    
    set(handles.show_1, 'String','Origin');
    set(handles.show_2, 'String','Processed');
    
    feature_method = get(handles.feature, 'Value');
    model = get(handles.model, 'Value');
    K = str2num(get(handles.k_number, 'String'))
    [binary_mask, pred] = predict_m(image, feature_method, model, K);
    axes(handles.axes2);
    imshow(binary_mask);
    set(handles.result, 'String', ['This is ', pred]);

function feature_Callback(hObject, eventdata, handles)
model = get(handles.model, 'Value');
feature_method = get(handles.feature, 'Value');
if model ==1
    if feature_method==1
        set(handles.k_number, 'String','7');
    else
        set(handles.k_number, 'String','5');
    end
end

function feature_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% --- Executes on selection change in model.
function model_Callback(hObject, eventdata, handles)
set(handles.edit_k, 'String','');
set(handles.k_number, 'String','x');
set(handles.show_loocv, 'String','Hold-out');
% --- Executes during object creation, after setting all properties.
function model_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in load_test_set.
function load_test_set_Callback(hObject, eventdata, handles)
    path = uigetdir;
    set(handles.result, 'String','Loading ...');
    drawnow;
    feature_method = get(handles.feature, 'Value');
    test_set = create_test_set(path, feature_method);
    path_test = 'test.mat'
    
    
    %load model KNN
    if feature_method==1
        train = 'datasets_humoment.mat'
        datasets = load(train);
        datasets = datasets.datasets;
    else
        datasets = load('datasets_hog.mat');
        datasets = datasets.datasets;
    end
    
    K = str2num(get(handles.k_number, 'String'));

    CM = KNN_evaluate_train_test_split(path_test, datasets, K);
    axes(handles.axes1);
    plotConfMat(CM,  {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
    axes(handles.axes2);
    imshow(imread('logo.png'));
    set(handles.result, 'String','Complete !');
    
% --- Executes on button press in show_loocv.
function show_loocv_Callback(hObject, eventdata, handles)
    set(handles.result, 'String','Loading ...');
    axes(handles.axes1);
    imshow(imread('logo.png'));
    axes(handles.axes2);
    imshow(imread('logo.png'));
    drawnow;
    feature = get(handles.feature, 'Value');
    model = get(handles.model, 'Value');
    if model==1 && feature==1
        %Hu-KNN
        K = str2num(get(handles.k_number, 'String'))
        CM = KNN_LOOCV('datasets_humoment.mat', K);
        axes(handles.axes1);
        plotConfMat(CM,  {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
        set(handles.show_1, 'String', 'LOOCV');
    elseif model==1 && feature==2
        %Hog-KNN
        K = str2num(get(handles.k_number, 'String'))
        CM = KNN_LOOCV('datasets_hog.mat', K);
        axes(handles.axes1);
        plotConfMat(CM,  {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
    elseif model==2 && feature==1
        %Hu-Neural Network
        load CM_test_hu_nn
        set(handles.show_1, 'String', 'Test Set');
        axes(handles.axes1);
        plotConfMat(CM_test,  {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
        load hu_net
        path = 'datasets_humoment.mat';

        datasets = load(path);
        datasets = datasets.datasets;
        label = datasets(:, 1);
        t = one_hot(label);
        x = ((datasets(:, 2:end)'));
        x = -sign(x).*(log10(abs(x)));
        y = net(x);
        classes = vec2ind(y);
        truth = vec2ind(t);
        CM = confusionmat(classes, truth, 'Order', [1,2,3, 4, 5]);
        set(handles.show_2, 'String', 'Dataset Set');
        axes(handles.axes2);
        plotConfMat(CM,  {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
    elseif model==2 && feature==2
        %Hog-Neural Network
        load CM_test_hog_nn
        set(handles.show_1, 'String', 'Test Set');
        axes(handles.axes1);
        plotConfMat(CM_test,  {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
        
        load hog_net
        path = 'datasets_hog.mat';

        datasets = load(path);
        datasets = datasets.datasets;
        label = datasets(:, 1);
        t = one_hot(label);
        x = ((datasets(:, 2:end)'));
        y = net(x);
        classes = vec2ind(y);
        truth = vec2ind(t);
        CM = confusionmat(classes, truth, 'Order', [1,2,3, 4, 5]);
        set(handles.show_2, 'String', 'Dataset Set');
        axes(handles.axes2);
        plotConfMat(CM,  {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
    end
    set(handles.result, 'String','Complete !');
    drawnow;

% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
    global idx files path;
    idx = idx - 1;
    if idx < 1
        idx = idx + 1;
        set(handles.result, 'String','Finish !');
    else
        set(handles.number_image, 'String',[num2str(idx), '/', num2str(length(files))]);
        set(handles.result, 'String','Loading ...');
        image = imread([path, '\',files(idx).name]);
        axes(handles.axes1);
        imshow(image);

        feature_method = get(handles.feature, 'Value');
        model = get(handles.model, 'Value');
        K = str2num(get(handles.k_number, 'String'))
        [binary_mask, pred] = predict_m(image, feature_method, model, K);
        axes(handles.axes2);
        imshow(binary_mask);
        set(handles.result, 'String', ['This is ', pred]);
    end

% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
    global idx files path;
    idx = idx + 1;
    if idx>length(files)
        idx = idx -1;
        set(handles.result, 'String','Finish !');
    else
        set(handles.number_image, 'String',[num2str(idx), '/', num2str(length(files))]);
        set(handles.result, 'String','Loading ...');
        image = imread([path, '\',files(idx).name]);
        axes(handles.axes1);
        imshow(image);

        feature_method = get(handles.feature, 'Value');
        model = get(handles.model, 'Value');
        K = str2num(get(handles.k_number, 'String'))
        [binary_mask, pred] = predict_m(image, feature_method, model, K);
        axes(handles.axes2);
        imshow(binary_mask);
        set(handles.result, 'String', ['This is ', pred]);
    end


% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
    addpath(genpath('.\ultis'));
    addpath(genpath('.\models'));
     global files path idx;
     idx = 1;
    [files, path] = uigetfile('*.jpg');
    set(handles.result, 'String','Loading ...');
    image = imread([path, files]);
    axes(handles.axes1);
    imshow(image);
    
    set(handles.show_1, 'String','Origin');
    set(handles.show_2, 'String','Processed');
    feature_method = get(handles.feature, 'Value');
    model = get(handles.model, 'Value');
    K = str2num(get(handles.k_number, 'String'));
    [binary_mask, pred] = predict_m(image, feature_method, model, K);
    axes(handles.axes2);
    imshow(binary_mask);

    set(handles.result, 'String', ['This is ', pred]);


% --- Executes on button press in reload.
function reload_Callback(hObject, eventdata, handles)
    global idx files path;
    if ischar(files)==1
        path_img = [path, '\',files];
    else
        path_img = [path, '\',files(idx).name];
    end
    set(handles.number_image, 'String',[num2str(idx), '/', num2str(length(files))]);
    set(handles.result, 'String','Loading ...');
    image = imread(path_img);
    axes(handles.axes1);
    imshow(image);

    feature_method = get(handles.feature, 'Value');
    model = get(handles.model, 'Value');
    K = str2num(get(handles.k_number, 'String'));
    [binary_mask, pred] = predict_m(image, feature_method, model, K);
    axes(handles.axes2);
    imshow(binary_mask);
    set(handles.result, 'String', ['This is ', pred]);



function k_number_Callback(hObject, eventdata, handles)
% hObject    handle to k_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k_number as text
%        str2double(get(hObject,'String')) returns contents of k_number as a double


% --- Executes during object creation, after setting all properties.
function k_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
