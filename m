Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E9FBC318CDC
	for <lists+kvmarm@lfdr.de>; Thu, 11 Feb 2021 15:05:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B28B4B34F;
	Thu, 11 Feb 2021 09:05:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3AQWFdQJ+GFf; Thu, 11 Feb 2021 09:05:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 167C34B457;
	Thu, 11 Feb 2021 09:05:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 99C204B33C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Feb 2021 09:05:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2pJ67d-HdJJU for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Feb 2021 09:05:17 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 283F54B325
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Feb 2021 09:05:17 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4293C31B;
 Thu, 11 Feb 2021 06:05:16 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4598B3F719;
 Thu, 11 Feb 2021 06:05:15 -0800 (PST)
Subject: Re: [PATCH kvmtool 03/21] ioport: Retire .generate_fdt_node
 functionality
To: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20201210142908.169597-1-andre.przywara@arm.com>
 <20201210142908.169597-4-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <3f1cf056-1913-cbbf-b9cd-12d1a840c468@arm.com>
Date: Thu, 11 Feb 2021 14:05:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20201210142908.169597-4-andre.przywara@arm.com>
Content-Language: en-US
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Andre,

On 12/10/20 2:28 PM, Andre Przywara wrote:
> The ioport routines support a special way of registering FDT node
> generator functions. There is no reason to have this separate from the
> already existing way via the device header.
>
> Now that the only user of this special ioport variety has been
> transferred, we can retire this code, to simplify ioport handling.

One comment below, but otherwise very nice cleanup.

>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  include/kvm/ioport.h |  4 ----
>  ioport.c             | 34 ----------------------------------
>  2 files changed, 38 deletions(-)
>
> diff --git a/include/kvm/ioport.h b/include/kvm/ioport.h
> index d0213541..a61038e2 100644
> --- a/include/kvm/ioport.h
> +++ b/include/kvm/ioport.h
> @@ -29,10 +29,6 @@ struct ioport {
>  struct ioport_operations {
>  	bool (*io_in)(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size);
>  	bool (*io_out)(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size);
> -	void (*generate_fdt_node)(struct ioport *ioport, void *fdt,
> -				  void (*generate_irq_prop)(void *fdt,
> -							    u8 irq,
> -							    enum irq_type));
>  };
>  
>  void ioport__map_irq(u8 *irq);
> diff --git a/ioport.c b/ioport.c
> index 667e8386..b98836d3 100644
> --- a/ioport.c
> +++ b/ioport.c
> @@ -56,7 +56,6 @@ static struct ioport *ioport_get(struct rb_root *root, u64 addr)
>  /* Called with ioport_lock held. */
>  static void ioport_unregister(struct rb_root *root, struct ioport *data)
>  {
> -	device__unregister(&data->dev_hdr);
>  	ioport_remove(root, data);
>  	free(data);
>  }
> @@ -70,30 +69,6 @@ static void ioport_put(struct rb_root *root, struct ioport *data)
>  	mutex_unlock(&ioport_lock);
>  }
>  
> -#ifdef CONFIG_HAS_LIBFDT
> -static void generate_ioport_fdt_node(void *fdt,
> -				     struct device_header *dev_hdr,
> -				     void (*generate_irq_prop)(void *fdt,
> -							       u8 irq,
> -							       enum irq_type))
> -{
> -	struct ioport *ioport = container_of(dev_hdr, struct ioport, dev_hdr);
> -	struct ioport_operations *ops = ioport->ops;
> -
> -	if (ops->generate_fdt_node)
> -		ops->generate_fdt_node(ioport, fdt, generate_irq_prop);
> -}
> -#else
> -static void generate_ioport_fdt_node(void *fdt,
> -				     struct device_header *dev_hdr,
> -				     void (*generate_irq_prop)(void *fdt,
> -							       u8 irq,
> -							       enum irq_type))
> -{
> -	die("Unable to generate device tree nodes without libfdt\n");
> -}
> -#endif
> -
>  int ioport__register(struct kvm *kvm, u16 port, struct ioport_operations *ops, int count, void *param)
>  {
>  	struct ioport *entry;
> @@ -107,10 +82,6 @@ int ioport__register(struct kvm *kvm, u16 port, struct ioport_operations *ops, i
>  		.node		= RB_INT_INIT(port, port + count),
>  		.ops		= ops,
>  		.priv		= param,
> -		.dev_hdr	= (struct device_header) {
> -			.bus_type	= DEVICE_BUS_IOPORT,
> -			.data		= generate_ioport_fdt_node,
> -		},

Since the dev_hdr field is not used anymore, maybe it could also be removed from
struct ioport in include/kvm/ioport.h?

Thanks,

Alex

>  		/*
>  		 * Start from 0 because ioport__unregister() doesn't decrement
>  		 * the reference count.
> @@ -123,15 +94,10 @@ int ioport__register(struct kvm *kvm, u16 port, struct ioport_operations *ops, i
>  	r = ioport_insert(&ioport_tree, entry);
>  	if (r < 0)
>  		goto out_free;
> -	r = device__register(&entry->dev_hdr);
> -	if (r < 0)
> -		goto out_remove;
>  	mutex_unlock(&ioport_lock);
>  
>  	return port;
>  
> -out_remove:
> -	ioport_remove(&ioport_tree, entry);
>  out_free:
>  	free(entry);
>  	mutex_unlock(&ioport_lock);
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
