function distances = distances(data_file)
    
    distance_data = load(data_file);
    m = max(max(distance_data(:,1:2)));
    distances = zeros(m,m);
    
    for lin = 1:length(distance_data)
        de = distance_data(lin,1);
        para = distance_data(lin,2);
        distance = distance_data(lin,3);
        distances(para,de) = distance;
        distances(de,para) = distance;
    end
end