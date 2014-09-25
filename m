From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] Hexagon: Remove useless select of NO_IOPORT_MAP
Date: Thu, 25 Sep 2014 12:11:42 +0200
Message-ID: <1411639902.7866.2.camel@x220>
References: <1411586511.19525.38.camel@x220>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1411586511.19525.38.camel@x220>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2014-09-24 at 21:21 +0200, Paul Bolle wrote:
> Actually, the only difference I found in the .config file was that after
> this patch the .config file contained
>     CONFIG_HEXAGON=y
> 
> I have no idea why. Did I botch my test?

Apparently I did. Retested using next-20140925. There's no difference in
the .config file before and after the patch. That's a good thing! This
select really is useless.


Paul Bolle
