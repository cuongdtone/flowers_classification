function varargout = GUI_flower_classification(varargin)
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
    global path files idx;
    path = uigetdir;
    files = dir([path, '\*.jpg']);
    idx = 1;

    set(handles.number_image, 'String',[num2str(idx), '/', num2str(length(files))]);
    image = imread([path, '\',files(idx).name]);
    axes(handles.axes1);
    imshow(image);

    set(handles.result, 'String','Loading ...');
    feature_method = get(handles.feature, 'Value');
    model = get(handles.model, 'Value');
    [binary_mask, pred] = predict(image, feature_method, model);
    axes(handles.axes2);
    imshow(binary_mask);
    set(handles.result, 'String', ['This is ', pred]);

function feature_Callback(hObject, eventdata, handles)

function feature_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% --- Executes on selection change in model.
function model_Callback(hObject, eventdata, handles)

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
    test_set = create_test_set(path);
    path_test = 'test.mat'
    train = 'datasets_humoment.mat'

    %load model
    datasets = load(train);
    datasets = datasets.datasets;
    K = 7;

    CM = HU_KNN_evaluate_train_test_split(path_test, datasets);
    axes(handles.axes1);
    plotConfMat(CM, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
    axes(handles.axes2);
    imshow(imread('logo.png'));
    set(handles.result, 'String','Complete !');
    
% --- Executes on button press in show_loocv.
function show_loocv_Callback(hObject, eventdata, handles)
    feature = get(handles.feature, 'Value');
    model = get(handles.model, 'Value');
    if model==1 && feature==1
        %Hu-KNN
        CM = HU_KNN_LOOCV();
        axes(handles.axes1);
        plotConfMat(CM, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
        axes(handles.axes2);
        imshow(imread('logo.png'));
    end

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
        [binary_mask, pred] = predict(image, feature_method, model);
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
        [binary_mask, pred] = predict(image, feature_method, model);
        axes(handles.axes2);
        imshow(binary_mask);
        set(handles.result, 'String', ['This is ', pred]);
    end


% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
    [files, path] = uigetfile('*.jpg');
    set(handles.result, 'String','Loading ...');
    image = imread([path, files]);
    axes(handles.axes1);
    imshow(image);

    feature_method = get(handles.feature, 'Value');
    model = get(handles.model, 'Value');
    [binary_mask, pred] = predict(image, feature_method, model);
    axes(handles.axes2);
    imshow(binary_mask);

    set(handles.result, 'String', ['Predict: ', pred]);
