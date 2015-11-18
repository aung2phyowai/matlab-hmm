% SUMMARY:  using viterbi decode to find the best path
%           V1k = p(x1|z1k)
%           Vnk = max{j} (Vn-1,j * p(znk|zn-1,j) * p(xn|znj))
%           save j every step, this is the path. 
% AUTHOR:   QIUQIANG KONG
% Created:  30-09-2015
% Modified: 17-11-2015 Add annotation
% -----------------------------------------------------------
% input:
%   p_xn_given_zn  z(xn|zn), size:N*Q
%   p_start        p(z1)
%   A              p(zn|zn-1)
% output:
%   path           seq of states, size:N
% ===========================================================
function path = ViterbiDecode(p_xn_given_zn, p_start, A)
[N,Q] = size(p_xn_given_zn);
path = zeros(N,1);
PATH = zeros(N,Q);

tmp = p_start.*p_xn_given_zn(1,:);
for i1 = 2:N
    C = bsxfun(@times, bsxfun(@times,tmp',A), p_xn_given_zn(i1,:));
    [tmp, points] = max(C,[],1);
    tmp = tmp / sum(tmp);
    PATH(i1-1,:) = points';
end
[~,path(N)] = max(tmp);

for i1 = N-1:-1:1
    path(i1) = PATH(i1, path(i1+1));
end


end