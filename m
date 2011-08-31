From: Avi Kivity <avi@redhat.com>
Subject: Re: [patch 00/36] Hexagon: Add support for Qualcomm Hexagon architecture
Date: Wed, 31 Aug 2011 08:48:04 +0300
Message-ID: <4E5DCB14.3030009@redhat.com>
References: <20110817163457.878854582@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110817163457.878854582@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On 08/17/2011 07:34 PM, Richard Kuo wrote:
> The following patch set is intended to add support for the Qualcomm Hexagon
> architecture to the Linux kernel.
>
> The Hexagon architecture is designed to deliver performance with low power
> over a variety of applications.  It has features such as multithreading,
> privilege levels, VLIW, and instructions geared toward efficient signal
> processing.  The port of Linux for Hexagon runs under a hypervisor layer.
>

Have you considered porting kvm to hexagon, so Linux can be used as the 
hypervisor as well?




-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.

