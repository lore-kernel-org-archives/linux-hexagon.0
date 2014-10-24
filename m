From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 08/47] kernel: Move pm_power_off to common code
Date: Fri, 24 Oct 2014 08:53:40 -0700
Message-ID: <20141024155340.GA22426@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-9-git-send-email-linux@roeck-us.net>
 <544A2017.7020804@imgtec.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kjlQCM+0EmlX8BHABTxQekNAn9jRj84zwg2oEd00Xn8=;
	b=6gJbs49Js5X6+X2KjFZRNW8Mri/kl8o26mCbR+2Rt0rdgBbPPWnGFXt2BZZ4hbP0DwHM8wR/4AuTzju85cmZrApvwlvOwZJjj7cxp0aL/4C/hAdxT/r3fhpGzn2eQGInvqQfFkPEDrMtkEGzf0718ymLTfBR/ArVG9UvtsAXSb0=;
Content-Disposition: inline
In-Reply-To: <544A2017.7020804@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, linux390@de.ibm.com, linux-alpha@vger.kernel.org, linux-am33-list@redhat.com, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux@openrisc.net, linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, x86@kernel.org, xen-devel@lists.xenproject.org

On Fri, Oct 24, 2014 at 10:47:03AM +0100, James Hogan wrote:
> Hi Guenter,
> 
> On 21/10/14 05:12, Guenter Roeck wrote:
> > pm_power_off is defined for all architectures. Move it to common code.
> > 
> > Have all architectures call do_kernel_power_off instead of pm_power_off.
> > Some architectures point pm_power_off to machine_power_off. For those,
> > call do_kernel_power_off from machine_power_off instead.
> > 
> > Acked-by: David Vrabel <david.vrabel@citrix.com>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Hirokazu Takata <takata@linux-m32r.org>
> > Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> > Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> > Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Acked-by: Richard Weinberger <richard@nod.at>
> > Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>
> 
> For metag:
> Acked-by: James Hogan <james.hogan@imgtec.com>
> 
Thanks!

Guenter
