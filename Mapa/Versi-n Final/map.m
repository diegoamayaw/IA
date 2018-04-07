function varargout = map(varargin)
% MAP MATLAB code for map.fig
%      MAP, by itself, creates a new MAP or raises the existing
%      singleton*.
%
%      H = MAP returns the handle to a new MAP or the handle to
%      the existing singleton*.
%
%      MAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAP.M with the given input arguments.
%
%      MAP('Property','Value',...) creates a new MAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before map_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to map_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help map

% Last Modified by GUIDE v2.5 19-Mar-2018 13:32:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @map_OpeningFcn, ...
                   'gui_OutputFcn',  @map_OutputFcn, ...
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


% --- Executes just before map is made visible.
function map_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to map (see VARARGIN)

% Choose default command line output for map
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
setappdata(handles.figure1, 'lat', [20.025105	16.8531086	20.4216103	18.5375878	18.9833329	21.8852562	20.9064323	25.2797312	19.7661213	20.5476288	19.1223754	19.0560481	19.415881	18.9815085	16.2371385	19.5291707	19.5562275	19.3976544	19.5901983	25.8884663	19.602311	22.8905327	25.5858931	19.8301251	21.161908	21.1571064	19.8598244	18.6504879	19.7050171	19.3471645	21.1899999	28.6329957	17.5515346	27.6799994	19.4326077	19.7050171	25.2594067	31.6903638	18.8060358	27.4827729	22.0025712	23.7369164	18.1344779	19.2452342	21.0749983	18.0344322	18.8838909	22.3656529	18.5986938	17.9956998	18.816823	18.9242095	24.8090649	28.1871201	21.151597	24.0277202	21.8552313	31.8667427	19.4968732	25.5891476	20.6596988	25.6775595	29.0729673	26.9317835	17.8099792	19.3184941	18.3448477	20.6786652	30.8889327	27.140659	19.994231	24.1426408	20.3307372	18.7599915	16.5515667	21.3634964	23.1946724	21.1250077	26.0117564	25.7904657	19.1138094	19.8975909	25.8690294	23.6448029	20.5870954	23.2494148	20.9673702	32.6245389	18.0005464	21.1066879	26.9080378	25.6866142	19.7059504	28.4070929	20.4849154	19.4630841	19.0217359	27.4779362	20.2108432	17.0594169	18.8504744	20.1010608	20.4566709	26.4958078	19.0313169	19.5134546	19.5572354	28.6916182	22.1694439	20.8177777	20.5270592	19.0412967	26.990021	18.6146871	20.5887932	21.9277923	20.5739314	25.4267244	21.293404	22.1564699	19.284383	29.0975367	31.8629677	22.2331041	14.9055567	16.37221	32.5685837	18.4665063	20.1277122	18.1345434	21.5041651	19.8160106	20.7157194	32.5149469	17.548366	19.9609426	19.3181521	19.2826098	25.5428443	20.9561149	18.0882429	16.7516009	19.4064492	20.68964	20.8884821	30.6141147	20.3887663	21.6769411	17.989456	19.5437751	22.7709249	19.9901766	20.6201831	19.4323039	27.3361939	19.173773	18.6101834	18.5001889	19.5803342	16.7370359	31.3277755	20.5279612	19.8599332	17.6416693	20.8489932	18.5057211	21.1367171	25.5858931	20.5260029	18.8126047	18.8478608	19.3284089	16.7581009	20.0973254	20.0615132	23.9355417	25.9167444	20.8878393	20.6295586	21.1454686	17.9803594	21.2379255	29.5458844	17.6582184	19.952089	28.027181	19.2986111	19.8405004	19.6352368	23.7680193	18.0281966	16.1842839	18.9173829	21.2929822	17.882617	19.1417201	18.2296099	18.8373179	18.9848015	28.2644599	21.8657329	25.9316354	23.4746427	23.1898592	19.5013282	31.9109332	20.9079101	26.074551	20.2830067	29.9071857	29.8034924	31.3011855	26.0909838	28.3705555	18.1039479	19.4736457	18.3578156	20.7281302	16.3693859	28.9288888	20.653407	19.9521591	26.0508406	19.3366788	20.4798167	20.8593042	21.3927664	21.2811908	21.182353	20.9626882	31.0250709	21.1086429	25.7627472	26.7856514	26.430077	29.3232963	16.9892472	15.6678137	15.8719795	16.3226994	18.6668459	19.7758168	21.5234878	20.4003697	26.5651421	17.949192	19.9333301	20.1297199	18.9131227	19.3161199	21.2691666	21.0190145	31.3268218	22.7421938	22.2475037	31.8978712	17.2522548	21.839444	20.2066604	20.7493289	21.0727549	16.5850458	19.8929732	18.6022222	18.2655453	16.432502	15.6658629	21.595554	18.6504879	20.2690026	19.8162473	18.1344779	17.5109792]);
setappdata(handles.figure1, 'lon', [-100.718241	-99.8236533	-103.5928664	-96.6053164	-97.783333	-102.2915677	-97.6738023	-100.0191857	-97.2455952	-104.0466211	-98.7667481	-98.2268599	-98.1393179	-104.0922185	-93.8986279	-103.442507	-99.2674713	-99.0384522	-96.9441242	-103.6213605	-99.1732936	-109.9167371	-100.0244665	-90.5349087	-86.8515279	-89.1020687	-102.0368641	-91.8074586	-103.4685183	-90.7200237	-104.6405555	-106.0691004	-99.5006322	-105.1713145	-99.133208	-103.4685183	-111.7776581	-106.4245478	-97.184414	-109.930367	-99.0018424	-99.1411154	-94.4589858	-103.7240868	-89.5195181	-99.0406186	-96.9237751	-102.2997344	-96.6811877	-94.6372866	-97.5107088	-99.2215659	-107.3940117	-105.4595306	-100.9367183	-104.6531759	-102.2596203	-116.5963713	-99.7232673	-103.485862	-103.3496092	-100.2596935	-110.9559192	-105.6666166	-97.7791724	-97.9233826	-99.5397344	-101.3544964	-108.1924159	-104.9157029	-102.7192577	-110.3127531	-102.0443851	-96.4623319	-94.9458806	-101.9291015	-106.416295	-101.6859605	-111.3477531	-108.985882	-104.3384616	-100.4499971	-97.5027376	-100.64279	-90.004663	-106.4111425	-89.5925857	-115.4522623	-94.5572847	-89.4521779	-101.4215236	-100.3161126	-101.1949825	-100.8850709	-89.7130643	-99.245302	-102.0921083	-99.549573	-98.0056153	-96.7216219	-97.1036396	-98.7591311	-97.3156131	-99.523821	-96.1354683	-101.6091876	-97.2464071	-100.5408622	-100.825278	-89.8030555	-97.4629119	-98.2061996	-105.327243	-99.3201479	-100.3898881	-99.9856344	-101.1957172	-100.9954254	-100.5239867	-100.9855409	-98.434873	-114.0843336	-112.8488631	-97.861099	-92.2634136	-94.217232	-116.6346969	-97.4003801	-98.1420491	-97.0740468	-104.8945887	-97.3570576	-97.5342015	-117.0382471	-98.5666077	-97.2140557	-98.2375146	-99.6556653	-103.4067861	-97.4063351	-96.1231999	-93.1029939	-102.0430476	-88.2022488	-97.6546961	-106.5142169	-97.8797934	-102.5891792	-92.9475061	-96.9101806	-102.5832539	-102.2834075	-103.0673833	-100.3554035	-112.2701486	-96.1342241	-90.7390245	-88.296146	-88.0440957	-92.6376186	-109.5489617	-100.8112885	-100.826261	-101.5516955	-104.0308285	-96.4578773	-98.4122162	-100.0244665	-104.7892254	-98.9548261	-99.1843676	-98.1973776	-93.3739498	-104.2793238	-97.0545256	-104.8823218	-98.7644621	-89.7480635	-87.0738851	-88.1496087	-102.3498336	-104.9007613	-104.4082908	-99.675904	-99.528557	-105.2916729	-99.3686111	-98.9801651	-103.4468419	-98.2076282	-94.5664262	-95.2087625	-103.8738031	-89.6039725	-99.131969	-96.1308302	-94.8718929	-98.9479948	-99.0930528	-105.4825971	-101.5940151	-105.9546744	-104.3939719	-106.2177141	-101.8521082	-116.2724304	-97.6833153	-103.397003	-103.4251691	-109.2999051	-109.6803106	-110.9381047	-106.9626447	-106.2549999	-94.0394524	-97.9246809	-100.6686262	-101.951295	-94.1944784	-114.1555555	-105.2253316	-100.1619222	-98.2978951	-99.0019149	-90.0793488	-90.3972052	-88.8914864	-89.6651628	-86.808626	-89.9345214	-114.8407776	-89.3974147	-102.9888129	-101.4282369	-99.146891	-100.9514187	-96.7132783	-96.4914257	-97.0767365	-95.24233	-97.0001223	-98.5759302	-98.3882723	-97.3370464	-99.2251794	-94.9145974	-101.5999994	-96.99528	-98.4293891	-98.1675031	-100.3558333	-101.2573586	-113.5311843	-98.9746578	-97.8481221	-116.6927744	-96.8591107	-104.802778	-96.7729224	-97.6311614	-97.7336939	-98.8128485	-97.1090347	-99.5180555	-100.556203	-92.713193	-92.0040599	-88.1565838	-91.8074586	-102.561961	-101.9055699	-94.4589858	-91.9930466])
setappdata(handles.figure1, 'numcall',0)
setappdata(handles.figure1, 'numcall2',0)
setappdata(handles.figure1, 'numcall3',0)

lat=getappdata(handles.figure1, 'lat');
lon=getappdata(handles.figure1, 'lon');

plot(lon,lat,'.r','MarkerSize',20)
plot_google_map
ciudades=importdata('ciudades.txt');
handles.popupmenu1.String = ciudades;
handles.popupmenu2.String = ciudades;

% UIWAIT makes map wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = map_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cds=get(handles.popupmenu1,'String');
cdorigen=get(handles.popupmenu1,'Value');

nombrecd=cds(cdorigen);

lat=getappdata(handles.figure1, 'lat');
lon=getappdata(handles.figure1, 'lon');

latcd=lat(cdorigen);
loncd=lon(cdorigen);

setappdata(handles.figure1, 'nomOrg',nombrecd)
setappdata(handles.figure1, 'latOrg',latcd)
setappdata(handles.figure1, 'lonOrg',loncd)

ori=plot(loncd,latcd,'.b','MarkerSize',20);
numcall=getappdata(handles.figure1, 'numcall');

if numcall ~= 0
    oripas=getappdata(handles.figure1, 'plo');
    delete(oripas)
    setappdata(handles.figure1, 'plo',ori)
else
    setappdata(handles.figure1, 'plo',ori)
    numcall=numcall+1;
    setappdata(handles.figure1, 'numcall',numcall)
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
;
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cds=get(handles.popupmenu2,'String');
cddestino=get(handles.popupmenu2,'Value');

nombrecd=cds(cddestino);

lat=getappdata(handles.figure1, 'lat');
lon=getappdata(handles.figure1, 'lon');

latcd=lat(cddestino);
loncd=lon(cddestino);

setappdata(handles.figure1, 'nomDst',nombrecd)
setappdata(handles.figure1, 'latDst',latcd)
setappdata(handles.figure1, 'lonDst',loncd)

dst=plot(loncd,latcd,'.g','MarkerSize',20);
numcall=getappdata(handles.figure1, 'numcall2');

if numcall ~= 0
    dstpas=getappdata(handles.figure1, 'plo2');
    delete(dstpas)
    setappdata(handles.figure1, 'plo2',dst)
else
    setappdata(handles.figure1, 'plo2',dst)
    numcall=numcall+1;
    setappdata(handles.figure1, 'numcall2',numcall)
end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
org=string(getappdata(handles.figure1, 'nomOrg'));
%latorg=string(num2str(getappdata(handles.figure1, 'latOrg')));
%lonorg=string(num2str(getappdata(handles.figure1, 'lonOrg')));
latorg=getappdata(handles.figure1, 'latOrg');
lonorg=getappdata(handles.figure1, 'lonOrg');

dst=string(getappdata(handles.figure1, 'nomDst'));
%latdst=string(num2str(getappdata(handles.figure1, 'latDst')));
%londst=string(num2str(getappdata(handles.figure1, 'lonDst')));
latdst=getappdata(handles.figure1, 'latDst');
londst=getappdata(handles.figure1, 'lonDst');
%c = ['(' org '(' latorg lonorg ')' dst '(' latdst londst ')' ')'];
c = ['(' org dst ')'];
str=join(c);
str=sprintf("source .midir; lisp.sh '%s'",str);
[status,cmdout] = unix(str);
mensaje='NO_SE_ENCONTRO_SOLUCION';
msg=strtrim(cmdout);

if strcmp(msg,'NO_SE_ENCONTRO_SOLUCION')==1
    f = warndlg('No se encontró solución entre ambas ciudades.','Error');
elseif strcmp(org,dst)==1
    f = warndlg('Se seleccionaron las mismas ciudades.','Error');
else
    aux=strsplit(strjoin(strsplit(strjoin(strsplit(cmdout,')')),'(')));
    trayecto=zeros(1,1000);
    flag=1;
    for i=1:length(aux)
        if ~isempty(strjoin(aux(i))) && flag==1
            trayecto=[aux(i)];
            flag=0;
        elseif ~isempty(strjoin(aux(i)))
            trayecto=[trayecto aux(i)];
        end
    end
    %encontrar id y obtener sus cordenadas para graficarlas
    lat=getappdata(handles.figure1, 'lat');
    lon=getappdata(handles.figure1, 'lon');
    cds=handles.popupmenu1.String;
    latTray=[latorg];
    lonTray=[lonorg];

    index=zeros(1,1000);
    h=1;
    j=1;
    bandera=1;
    while bandera==1
        if strcmp(strjoin(cds(j)),strjoin(trayecto(h)))==1
            index(h)=j;
            h=h+1;
            j=1;
        else
            j=j+1;
        end
        if h>length(trayecto)
            bandera=0;
        end
    end

    h=1;
    while h<=length(trayecto)
        latTray=[latTray lat(index(h))];
        lonTray=[lonTray lon(index(h))];
        h=h+1;
    end
    latTray=[latTray latdst];
    lonTray=[lonTray londst];

    handles.listbox1.String=[trayecto];
    numcall=getappdata(handles.figure1, 'numcall3');

    for j=1:(length(latTray)-1)
        if j==1
            trayplt=[plot([lonTray(j);lonTray(j+1)],[latTray(j);latTray(j+1)],'k','LineWidth',2)];
        else
            trayplt=[trayplt plot([lonTray(j);lonTray(j+1)],[latTray(j);latTray(j+1)],'k','LineWidth',2)];
        end
    end

    if numcall ~= 0
        traypltpas=getappdata(handles.figure1, 'tplt');
        for j=1:(length(traypltpas)-1)
            delete(traypltpas)
        end
        setappdata(handles.figure1, 'tplt',trayplt)
    else
        setappdata(handles.figure1, 'tplt',trayplt)
        numcall=numcall+1;
        setappdata(handles.figure1, 'numcall3',numcall)
    end
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
