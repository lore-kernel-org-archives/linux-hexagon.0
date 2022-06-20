From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [alobakin:bitops 3/7] block/elevator.c:222:9: sparse: sparse:
 cast from restricted req_flags_t
Date: Mon, 20 Jun 2022 21:21:12 +0200
Message-ID: <20220620192112.ghyegqvtj3ud7zla@mail>
References: <202206191726.wq70mbMK-lkp@intel.com>
 <20220617144031.2549432-1-alexandr.lobakin@intel.com>
 <20220620135146.2628908-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/0jxbATVEDKJnIt6ABi4UcKvefavHfALqV2faNdj1xk=;
        b=E2w9SsK622uI3mRxf9d1ClkzeccxGN5eH53Unw5M4E4b0/ciI8EdJTKHuIfMDb3oYJ
         YTDXeesnCEDlZdX1+VVgBVcyrcc1kjQhXUl7QhujJt1ZGMR2a7e0T1PcupO4HUGZdiFD
         39IpbFP7Xi0rCmSlptLDWbdMNNlf9hIPR48cNLSNpAavFS7XyQE1FOIVXFDngH7HEOLz
         EtQ6srucKJaxyDr+flGCni5+E4AlE5K+pYwH7NKtnjDBeQN4QNkmdg+EOpiVfF9aJDQD
         P0cQv8kp38qvfnww9Mbzg40KkFzsj1eem1AjDaHXAaN8ujWQnF1PUAt6Vyo1EdmDOpUI
         J49A==
Content-Disposition: inline
In-Reply-To: <20220620135146.2628908-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org

On Mon, Jun 20, 2022 at 03:51:46PM +0200, Alexander Lobakin wrote:
> From: kernel test robot <lkp@intel.com>
> Date: Sun, 19 Jun 2022 17:20:05 +0800
> 
> Also, could someone please help me with this? I don't get what went
> wrong with sparse, it's not even some new code, just moving old
> stuff.

Hi,

The first sparse's warnings (sparse: preprocessor token __ATOMIC_*) are already
fixed (and most probably, the bots have already taken the fix).
I'm working on the second ones (sparse: unreplaced symbol).

-- Luc (Sparse's maintainer)
