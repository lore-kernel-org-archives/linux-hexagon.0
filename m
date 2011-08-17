From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [patch 00/36] Hexagon: Add support for Qualcomm Hexagon
 architecture
Date: Wed, 17 Aug 2011 14:42:13 -0500
Message-ID: <20110817194213.GB2694@codeaurora.org>
References: <20110817163457.878854582@codeaurora.org>
 <1313607653.7431.3.camel@knife>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1313607653.7431.3.camel@knife>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zan Lynx <zlynx@acm.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wed, Aug 17, 2011 at 01:00:44PM -0600, Zan Lynx wrote:
> I am curious about the hypervisor layer.
> 
> I can guess that it's an attempt to abstract away low level hardware
> changes, a sort of software version of CPU microcode.
> 
> Or maybe it's a Transmeta kind of thing with dynamic recompilation into
> a quickly evolving VLIW instruction set.
> 
> But what's the real reason?

There are definitely opportunities for bonus features with hypervisors,
but the real reason is just to allow multiple guests to run concurrently
on a machine.

Thanks,
Richard Kuo

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
