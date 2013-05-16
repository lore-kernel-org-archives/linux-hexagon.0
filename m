From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: MFD: move ssbi driver into drivers/mfd
Date: Thu, 16 May 2013 11:49:17 +0200
Message-ID: <20130516094917.GD22822@zurbaran>
References: <20130429162115.GA6893@kroah.com>
 <8yafvy92gfs.fsf@huya.qualcomm.com>
 <CA+55aFxaMP+=uMLLvnLHz_E0GStrDf_zO3XhVCDGHbk=tV6CqA@mail.gmail.com>
 <201304300000.19488.arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201304300000.19488.arnd@arndb.de>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Brown <davidb@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

Hi Arnd,

On Tue, Apr 30, 2013 at 12:00:19AM +0200, Arnd Bergmann wrote:
> There is no reason for ssbi to have its own top-level driver directory
> when the only users of this interface are all MFD drivers. The only
> mainline driver using it at the moment (PM8921) is marked broken and in
> fact does not compile. I have verified that fixing the trivial build
> breakage in pm8921 links in the new ssbi code just fine, but that
> can be a separate patch.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/Kconfig              |  2 --
>  drivers/Makefile             |  1 -
>  drivers/mfd/Kconfig          |  3 ++-
>  drivers/mfd/Makefile         |  2 +-
>  drivers/{ssbi => mfd}/ssbi.c |  0
>  drivers/ssbi/Kconfig         | 16 ----------------
>  drivers/ssbi/Makefile        |  1 -
>  7 files changed, 3 insertions(+), 22 deletions(-)
Applied to my mfd-next tree, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
