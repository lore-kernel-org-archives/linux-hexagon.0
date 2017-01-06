From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 4/7] x86: put msr-index.h in uapi
Date: Fri, 6 Jan 2017 22:50:34 +0200
Message-ID: <CAHp75VdDfopdSy-7oy87ZeosDB9+FN4zFBhErPWLQB7tH81zTw@mail.gmail.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com> <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DX7WmIueqXQ1GEtKMnFbhkERt2X0qmm/lU4v0ln5KdQ=;
        b=agpgZiSZhuA/CT5EP5rEl9F0cFcArtBehYnCumkpZMtx8fEhbv9Cf5hsBtmPyFjPY2
         9soz6rTLiOHuSORLSZVZF9j9EeSedzIIYawqvQoZ4XKDjV5iPfyJVN//lLbNAPBbLqmo
         f7vhqXzfy/XfOV4ZDQsAMkgkEo4My7sq2VAFMHiITcnPknlgmKNA/3jkDDfoq+m09arR
         ryi2wc6C4sADNs76ivLXLJUYkTtmRDlcvSXTmFZ9pRNC9lqk4eYg2OMar0ahauXRBSC3
         11WcRcDasWHxTJpfyXNbAKjCzyp3GTABwv8dP3BcuWIRaAXJY6VtL3IqewN0RRLkAPRg
         DlBQ==
In-Reply-To: <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Arnd Bergmann <arnd@arndb.de>, mmarek@suse.com, linux-kbuild@vger.kernel.org, Linux Documentation List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, open list:LINUX FOR POWERPC PA SEMI PWRFICI

On Fri, Jan 6, 2017 at 11:43 AM, Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> This header file is exported, thus move it to uapi.

Just hint for the future:
-M (move)
-C (copy)
-D (delete) [though this is NOT for applying]

-- 
With Best Regards,
Andy Shevchenko
