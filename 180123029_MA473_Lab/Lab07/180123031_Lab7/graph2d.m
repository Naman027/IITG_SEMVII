function graph2d(S,U,grph,qn,ind,meth)
    figure;
    plot(S(ind),U(1,ind)); 
    hold on; 
    plot(S(ind),U(end,ind)); 
    hold off;
    legend('H(R,0) at t = 0', 'H(R,T) at t = T'); 
    xlabel('R'); 
    ylabel('H(R, t)');
    title(sprintf('H(R,t) using %s',meth));
    saveas(gcf,sprintf('q%d_%d.png',qn,grph)); 
end