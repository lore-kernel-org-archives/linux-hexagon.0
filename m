From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 01/35] Hexagon: Add generic headers
Date: Wed, 31 Aug 2011 22:00:41 +0200
Message-ID: <1400760.2CJ9v55MlQ@wuerfel>
References: <20110830190729.923334292@codeaurora.org> <201108311524.42373.arnd@arndb.de> <20110831195111.GA29918@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110831195111.GA29918@huya.qualcomm.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: David Brown <davidb@codeaurora.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wednesday 31 August 2011 12:51:11 David Brown wrote:
> On Wed, Aug 31, 2011 at 03:24:42PM +0200, Arnd Bergmann wrote:
> > On Tuesday 30 August 2011, Richard Kuo wrote:
> > > Reworked to use the Kbuild generic headers mechanism.
> > > 
> > > Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Any suggestions on what path this code should flow to get into the
> kernel?

It should get into linux-next now and then get submitted directly to
Linus at the start of the merge window.

I'm happy to take anything that concerns hexagon and arm likewise into
the arm-soc tree.

While I am the de-facto gatekeeper for new architectures, I have not
seen a reason to start a consolidated minor-architectures tree to collect
these.

	Arnd
