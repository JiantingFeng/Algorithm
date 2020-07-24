% DOA with lower complexity
function X = AoALocate(BASE_STATION, THETA, PHI)
N = length(BASE_STATION); % number of base station
D = zeros(2 * N, 3);
P = zeros(2 * N, 1);
for k = 1:N
   D(2 * k - 1, :) = [sin(PHI(k)), -cos(PHI(k)), 0];
   D(2 * k, :) = [cos(THETA(k)), 0, -cos(PHI(k))*sin(THETA(k))];
   P(2 * k - 1) = BASE_STATION(k, 1) * sin(PHI(k)) - BASE_STATION(k, 2) * cos(PHI(k));
   P(2 * k) = BASE_STATION(k, 1) * cos(THETA(k)) - BASE_STATION(k, 3) * cos(PHI(k)) * sin(THETA(k));
end
X = (D'*D)\D'*P;
if X(1) < 0
    X(3) = -X(3);
end