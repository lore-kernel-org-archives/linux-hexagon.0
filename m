From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [patch V3 05/20] acpi: Remove header dependency
Date: Sat, 21 Mar 2020 14:23:58 +0200
Message-ID: <CAHp75VdpXxg4NSSg-jxKc51emJxhJQgLpG1Rv-xq7ouWz+xBuA@mail.gmail.com>
References: <20200321112544.878032781@linutronix.de>
 <20200321113241.246190285@linutronix.de>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ao4Jy8e8i2H3r6C7mhPUev+j75PjWe4TRVOreHP2VzM=;
 b=guZnHeGo0HvHKP2uIKtZiCtNOUIkrUT7OLzB66Ehtw0EiRz0K0c6LtX4CWuNZp6QIL
 YrUqqmUsqOQIHILQRs1SrnxRO54uRVwILm5bNdlpUGX6dcExdOPMfmuKHkPcvMtu6WbT
 /P7MLfISznzr7ogM6J98U4cpx8/lCga6dEpI2eG7/1joslz9HVe0MCBWrJjlYlA5S7Mc
 eufctIYPsclmo3tJk89MVDURTNM43DP4w2vS8LbbG17swocgZVGzaGEA17iUCtLk8pQy
 WDK9dsn4zUgoCJeFNLPI823x3rR/fKz2B+dGyCO9zePvxDJWWT98LbXkAlCqWcnM1iF7
 hq3A==
In-Reply-To: <20200321113241.246190285@linutronix.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: USB <linux-usb@vger.kernel.org>, linux-ia64@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org, Sebastian Siewior <bigeasy@linutronix.de>, Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Vincent Chen <deanbo422@gmail.com>, Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, kbuild test robot <lkp@intel.com>, Brian Cain <bcain@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, "Paul E . McKenney" <paulmck@kernel.org>, linux-hexagon@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-csky@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.d>

On Sat, Mar 21, 2020 at 1:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> In order to avoid future header hell, remove the inclusion of
> proc_fs.h from acpi_bus.h. All it needs is a forward declaration of a
> struct.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com> # for PDx86

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/platform/x86/dell-smo8800.c                      |    1 +
>  drivers/platform/x86/wmi.c                               |    1 +
>  drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c |    1 +
>  include/acpi/acpi_bus.h                                  |    2 +-
>  4 files changed, 4 insertions(+), 1 deletion(-)
>
> --- a/drivers/platform/x86/dell-smo8800.c
> +++ b/drivers/platform/x86/dell-smo8800.c
> @@ -16,6 +16,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/miscdevice.h>
>  #include <linux/uaccess.h>
> +#include <linux/fs.h>
>
>  struct smo8800_device {
>         u32 irq;                     /* acpi device irq */
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -29,6 +29,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/uuid.h>
>  #include <linux/wmi.h>
> +#include <linux/fs.h>
>  #include <uapi/linux/wmi.h>
>
>  ACPI_MODULE_NAME("wmi");
> --- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> +++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> @@ -19,6 +19,7 @@
>  #include <linux/acpi.h>
>  #include <linux/uaccess.h>
>  #include <linux/miscdevice.h>
> +#include <linux/fs.h>
>  #include "acpi_thermal_rel.h"
>
>  static acpi_handle acpi_thermal_rel_handle;
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -80,7 +80,7 @@ bool acpi_dev_present(const char *hid, c
>
>  #ifdef CONFIG_ACPI
>
> -#include <linux/proc_fs.h>
> +struct proc_dir_entry;
>
>  #define ACPI_BUS_FILE_ROOT     "acpi"
>  extern struct proc_dir_entry *acpi_root_dir;
>
>


-- 
With Best Regards,
Andy Shevchenko
