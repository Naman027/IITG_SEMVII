function graph3d(S,U,Time,grph,qn,meth)
    figure; 
    surf(S,Time,U); 
    xlabel('R'); 
    ylabel('t'); 
    zlabel('H(R,t)'); 
    title(sprintf('H(R,t) using %s',meth));
    saveas(gcf,sprintf('q%d_%d.png',qn,grph)); 
end