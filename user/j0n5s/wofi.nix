let 
  font = "FiraCode Nerd Font";
  primary_accent = "61ffef"; #"cba6f7";
  secondary_accent = "89b4fa";
  tertiary_accent = "f5f5f5";
  background = "11111B";
  opacity = "0.9";
in {
    programs.wofi = {
        enable = true;
        settings = {
            allow_images = true;
            width = "25%";
            hide_scroll = true;
            term = "foot";
            show = "drun";
            disable_prime = true;
            #normal_window = true;
        };
        style =''
        * {
          font-family: ${font},monospace;
          font-weight: bold;
        }
        #window {
          border-radius: 10px;
          background: #${background};
          opacity: ${opacity};
        }
        #input {
          border-radius: 100px;
          margin: 20px;
          padding: 15px 25px;
          background: #${background};
          color: #${tertiary_accent};
        }
        #outer-box {
          font-weight: bold;
          font-size: 14px;
        }
        #entry {
          margin: 10px 80px;
          padding: 20px 20px;
          border-radius: 200px;
        }
        #entry:selected{
          background-color:#${primary_accent};
          color: #${background};
        }
        #entry:hover {
        }
        '';
    };
}
