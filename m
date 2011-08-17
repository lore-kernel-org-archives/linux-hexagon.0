From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 13/36] Hexagon: Support dynamic module loading.
Date: Wed, 17 Aug 2011 21:41:37 +0200
Message-ID: <1800933.OQ1SvESjJ0@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163521.072192837@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110817163521.072192837@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Wednesday 17 August 2011 11:35:10 Richard Kuo wrote:
> + * module_alloc - wrapper around vmalloc
> + * @size - memory size to vmalloc
> + */
> +void *module_alloc(unsigned long size)
> +{
> +       if (size == 0)
> +               return NULL;
> +       return vmalloc_exec(size);
> +}
> +
> +/*
> + * module_free - free memory returned from module_alloc
> + * @mod - pointer to module?
> + * @module_region - pointer to module region?
> + */
> +void module_free(struct module *mod, void *module_region)
> +{
> +       vfree(module_region);
> +}
> +
> +/*
> + * module_finalize - perform platform-dependent fixups.
> + */
> +int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
> +                       struct module *me)
> +{
> +       return 0;
> +}
> +
> +/*
> + * module_arch_cleanup - Any cleanup needed with module
> + * @mod - pointer to module
> + * @module_region - pointer to module region
> + */
> +void module_arch_cleanup(struct module *mod)
> +{
> +}

These are the default implementations that are now (as of 3.1) provided
by common code, so you can just omit your own definitions.

	Arnd
