From: Jon Pry <jonpry@gmail.com>
Subject: Bare metal hexagon status
Date: Sat, 16 Mar 2013 16:59:39 -0400
Message-ID: <CA+3xLx7yCG9AqxpTg7Xm+TjyuHr3gfwrPpfn3a9dJwG9UNxWZw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=a89K1kbNUUADSE8Effo6B3ItLOZ7Xh0gqApw+mK2+XI=;
        b=uOd/GdfsfJgkDzE9CfOD+K9GN9nhUQv3W34UKtxkPSw+atmaM5b04Umdc4MiJbqk50
         QwTbvuf6TugKOZa4sw7n0quX01sYtdMNpzWkLtPIN4OQS5tcerBLw5dh30yLDp/qksBd
         cf7RTlDve5FhrOMWdfFGFqc6lncfmfRjnfclERWBU4mH+oPaZDehWM02dt0aFe3Cw2/R
         zpo5iqo+3xS19FpMoec+PeHmY3oFqEHBYxoZlcd3EJOS+hFDSZ4fDxQrtIKqNALvkXbF
         hwxPXvPT7dCoBeCUSn+Fdudd0/enxCHz9PQZWcFEXHCydXPlMobm5FGch9HyftswtYcg
         1j6g==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-hexagon@vger.kernel.org

The port to bare metal hexagon appears to be fully functional on V3
processors. All cores are running under SMP. It has not yet been
tested on V2. So anybody interested in Hexagon programming should be
able to mess with it now.

I did have some problems implementing vmwait, which I assume saves
some power. Perhaps someone here knows how the wait(Rs) instruction
works. I have no idea what the register argument is doing.  Analysis
of the Q6 firmware was not clear. Sometimes it uses the thread id,
sometimes all of ssr, and other times some strange magic numbers. It
also appears that wait is run with exception bit cleared and
interrupts enabled. Which seems like a bad idea since vmwait is called
with interrupts disabled.

~Jon
