From: Rob Landley <rob@landley.net>
Subject: Re: hexagon: CONFIG_PAGE_SIZE_1MB?
Date: Sun, 18 May 2014 10:53:44 -0500
Message-ID: <5378D788.3090004@landley.net>
References: <1400326363.13824.8.camel@x220>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1400326363.13824.8.camel@x220>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Paul Bolle <pebolle@tiscali.nl>, Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

On 05/17/14 06:32, Paul Bolle wrote:
> Richard,
> 
> 0) There are two checks for CONFIG_PAGE_SIZE_1MB in Linux' hexagon code.
> But there's no Kconfig symbol PAGE_SIZE_1MB.

Query: did we ever get a hexagon emulator that lets civilians like
myself poke at it? I haven't been able to play with this target since I
lost access to the comet board...

Rob
