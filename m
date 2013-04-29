From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: MFD: move ssbi driver into drivers/mfd
Date: Mon, 29 Apr 2013 15:10:08 -0700
Message-ID: <20130429221008.GA32591@kroah.com>
References: <20130429162115.GA6893@kroah.com>
 <8yafvy92gfs.fsf@huya.qualcomm.com>
 <CA+55aFxaMP+=uMLLvnLHz_E0GStrDf_zO3XhVCDGHbk=tV6CqA@mail.gmail.com>
 <201304300000.19488.arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+bKpuHjXwCP/xCOE0uMiyb5Cvs7X/psuieTPTyegXtY=;
        b=SGXxfj5NilVm9H32D7d0zCUjPiqGtGlkYKv3+RmbDsFVRUg5EWxEY+D9zQ1Yl1C8r0
         1id7tUumAsqVmK+qctbSKQk5EeWlcFKUc5JWJ/EMcc9t3YXb7oADVjRqzVJseTN5RjBz
         +SJv6Q3j/fSKAloQwLz6f3pT+js9/F+QleX10=
Content-Disposition: inline
In-Reply-To: <201304300000.19488.arnd@arndb.de>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Samuel Ortiz <sameo@linux.intel.com>, David Brown <davidb@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
