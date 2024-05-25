def read_flower_names(filename):
    with open(filename, 'r') as file:
        flowers = [line.strip() for line in file.readlines()]
    return flowers

def generate_plsql_script(flowers, num_records, output_filename):
    theater_id_start = 111
    min_capacity = 20
    max_capacity = 300

    with open(output_filename, 'w') as file:
        file.write("BEGIN\n")
        for i in range(num_records):
            theater_id = theater_id_start + i
            theater_name = flowers[i % len(flowers)]
            capacity = random.randint(min_capacity, max_capacity)
            file.write(f"    INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES ({theater_id}, '{theater_name}', {capacity});\n")
        file.write("END;\n")
        file.write("/\n")

if __name__ == "__main__":
    flowers = read_flower_names('flower_names.txt')
    num_records = 400
    output_filename = 'insert_theaters.sql'
    generate_plsql_script(flowers, num_records, output_filename)
    print(f"PL/SQL script '{output_filename}' generated successfully.")



























# # from scapy.all import *
# # import sys
# #
# #
# # def dns_query(domain):
# #     # DNS query for CAA record
# #     dns_request = DNS(rd=1, qd=DNSQR(qname=domain, qtype="CAA"))
# #
# #     # DNS packet with query
# #     dns_packet = IP(dst="8.8.8.8") / UDP(dport=53) / dns_request
# #
# #     # Send the packet and receive the response
# #     dns_response = sr1(dns_packet, verbose=0)
# #     dns_response.show()
# #     # if any response was sent from dns server
# #     if dns_response:
# #         caa_res = []
# #         # extract caa responses
# #         for i in range(dns_response[DNS].ancount):
# #             if dns_response[DNSRR][i].type == 257:  # Type 1 corresponds to A record (IPv4 address)
# #                 caa_res += [dns_response[DNSRR][i].rdata[2:].decode('utf-8')]
# #
# #         # print caa responses
# #         if caa_res:
# #             print("CAA records:")
# #             [print(rr) for rr in caa_res]
# #     else:
# #         print("No response was sent\n")  # ask if this is what needs to be print in this case
# #
# # if __name__ == "__main__":
# #     if len(sys.argv) != 2:
# #         print("Usage: python dnstoolkit.py <domain>")
# #     else:
# #         target_domain = sys.argv[1]
# #         dns_query(target_domain)
# #
# #
# #     # # DNS query for CAA record
# #     # dns_request = IP(dst="8.8.8.8") / UDP(dport=53) / DNS(rd=1, qd=DNSQR(qname=domain, qtype=257))
# #     #
# #     # # Send the packet and receive the response
# #     # dns_response = sr1(dns_request, verbose=0, timeout=1)
# #     #
# #     # # if any response was sent from dns server
# #     # if dns_response:
# #     #     caa_res = []
# #     #     # extract caa responses
# #     #     for i in range(dns_response[DNS].ancount):
# #     #         if dns_response[DNSRR][i].type == 257:  # Type 1 corresponds to A record (IPv4 address)
# #     #             caa_res += [dns_response[DNSRR][i].rdata[2:].decode('utf-8')]
# #     #
# #     #     # print caa responses
# #     #     if caa_res:
# #     #         print("CAA records:")
# #     #         [print(rr) for rr in caa_res]
# #     # else:
# #     #     print("No response was sent\n")  # ask if this is what needs to be print in this case
# #
# #     from scapy.all import *
# #     import sys
# #     import time
# #
# #     subdomains_file = "wordlist_TLAs.txt"
# #
# #
# #     def query_dns(domain, type, dns_server="8.8.8.8"):
# #         # Craft a DNS query packet
# #         dns_query = IP(dst=dns_server) / UDP(dport=53) / DNS(rd=1, qd=DNSQR(qname=domain, qtype=type))
# #
# #         # Send the DNS query and receive the response
# #         dns_response = sr1(dns_query, verbose=0, timeout=1)
# #         dns_response.show()
# #         res = []
# #         # Parse the DNS response and extract IP addresses
# #         if dns_response and DNS in dns_response and dns_response[DNS].ancount > 0:
# #             for i in range(dns_response[DNS].ancount):
# #                 if dns_response[DNSRR][i].type == type:  # Type 1 corresponds to A record (IPv4 address)
# #                     res += [dns_response[DNSRR][i].rdata]
# #
# #         return res
# #
# #
# #     def caa_query(domain):
# #         # DNS query for CAA record
# #         caa_res = query_dns(domain, 257, "1.1.1.1")
# #         if caa_res:
# #             print("CAA records:")
# #             [print(rr[2:].decode()) for rr in caa_res]
# #
# #
# #     def load_subdomains():
# #         try:
# #             with open(subdomains_file, 'r') as file:
# #                 return [line.strip() for line in file.readlines() if line.strip()]
# #         except FileNotFoundError:
# #             print(f"Error: File '{subdomains_file}' not found.")
# #             return None
# #
# #
# #     def dns_map(domain):
# #         start_time = time.time()
# #         print(f"dnsmap {0.36} - DNS Network Mapper\n")
# #         print(f"[+] searching (sub)domains for {target_domain} using built-in wordlist")
# #
# #         total_domains = 0
# #         total_internal_ips = 0
# #         wordlist = load_subdomains()
# #         if wordlist:
# #             dns_server = query_dns(domain, 2)[0].decode()
# #             if dns_server:
# #                 for subdomain in wordlist:
# #                     sdomain = f"{subdomain}.{domain}"
# #                     ip_addresses = query_dns(sdomain, 1, dns_server)
# #
# #                     if ip_addresses:
# #                         total_domains += 1
# #
# #                         print(f"\n{sdomain}")
# #                         for i, ip in enumerate(ip_addresses, start=1):
# #                             print(f"IP address #{i}: {ip}")
# #                             total_internal_ips += 1
# #
# #                 print(f"\n[+] {total_domains} (sub)domains and {total_internal_ips} IP address(es) found")
# #                 end_time = time.time()  # Record the end time
# #                 completion_time = int(end_time - start_time)  # Calculate the completion time
# #
# #                 print(f"[+] completion time: {completion_time} second(s)")
# #
# #
# #     def whois_query(whois_server, domain):
# #
# #         with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
# #             s.connect((whois_server, 43))
# #             s.sendall(f"{domain}\r\n".encode())
# #             laddr = s.getsockname()  # Get the local address as a tuple (host, port)
# #             lport = laddr[1]
# #
# #             sniffed_packets = sniff(filter=f"dst port {lport}", timeout=5)
# #
# #             # Check if any packets were captured
# #             if sniffed_packets:
# #                 raw_response = ""
# #
# #                 # Process each packet
# #                 for packet in sniffed_packets:
# #                     if packet.haslayer(Raw):
# #                         # Accessing the Raw layer
# #                         raw_data = packet[Raw].load
# #                         raw_response = raw_response + raw_data.decode('utf-8')
# #
# #                 return raw_response
# #             else:
# #                 print("No response sniffed.")
# #                 return None
# #
# #
# #     def pecform_whois(domain):
# #         initial_whois_server = "whois.iana.org"
# #         initial_whois_response = whois_query(initial_whois_server, domain)
# #         refer_server = extract_refer_server(initial_whois_response)
# #         whois_response = whois_query(refer_server, domain)
# #
# #         if whois_response:
# #             print(whois_response)
# #         else:
# #             print("WHOIS query failed.")
# #
# #         # in case that the domain ends with com
# #         if domain.endswith(".com"):
# #             registrar = extract_registrar_whois_server(whois_response)
# #             full_whois_response = whois_query(registrar, domain)
# #             if whois_response:
# #                 print(full_whois_response)
# #             else:
# #                 print("WHOIS query failed.")
# #
# #
# #     def extract_refer_server(response_text):
# #         pattern = r'refer:\s+([\w.-]+)'
# #         match = re.search(pattern, response_text)
# #         if match:
# #             return match.group(1)
# #         else:
# #             return None
# #
# #
# #     def extract_registrar_whois_server(response_text):
# #
# #         pattern = r'Registrar WHOIS Server:\s+([\w.-]+)'
# #         match = re.search(pattern, response_text)
# #         if match:
# #             return match.group(1)
# #         else:
# #             return None
# #
# #
# #     if __name__ == "__main__":
# #         if len(sys.argv) != 2:
# #             print("Usage: python DNStoolkit.py <domain>")
# #         else:
# #             target_domain = sys.argv[1]
# #             caa_query(target_domain)
# #             print()
# #             pecform_whois(target_domain)
# #             print()
# #             dns_map(target_domain)
# #
# #
# #
# #
# #
import random

def read_flower_names(filename):
    with open(filename, 'r') as file:
        flowers = [line.strip() for line in file.readlines()]
    return flowers

def generate_plsql_script(flowers, num_records, output_filename):
    theater_id_start = 111
    min_capacity = 20
    max_capacity = 300

    with open(output_filename, 'w') as file:
        file.write("BEGIN\n")
        for i in range(num_records):
            theater_id = theater_id_start + i
            theater_name = flowers[i % len(flowers)]
            capacity = random.randint(min_capacity, max_capacity)
            file.write(f"    INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES ({theater_id}, '{theater_name}', {capacity});\n")
        file.write("END;\n")
        file.write("/\n")

if __name__ == "__main__":
    flowers = read_flower_names('flower_names.txt')
    num_records = 400
    output_filename = 'insert_theaters.sql'
    generate_plsql_script(flowers, num_records, output_filename)
    print(f"PL/SQL script '{output_filename}' generated successfully.")


subscriber_ids = [
    490, 596, 176, 646, 32, 925, 628, 352, 884, 408, 762, 131, 603, 111, 855, 859, 463, 452, 595, 745, 947, 317, 734, 141,
    952, 85, 264, 70, 446, 16, 165, 215, 116, 792, 938, 856, 278, 471, 527, 615, 750, 537, 999, 167, 403, 912, 648, 709,
    129, 967, 767, 76, 582, 409, 139, 58, 524, 242, 903, 445, 313, 845, 526, 273, 881, 987, 149, 284, 975, 318, 644, 413,
    338, 11, 116, 619, 588, 165, 4, 113, 366, 329, 344, 397, 129, 200, 952, 886, 371, 456, 48, 801, 626, 547, 866, 450, 904,
    544, 519, 973, 628, 684, 500, 512, 288, 446, 912, 943, 93, 349, 30, 863, 506, 923, 811, 25, 974, 273, 653, 653, 823, 422,
    517, 360, 780, 679, 427, 767, 109, 612, 827, 315, 306, 68, 617, 787, 511, 543, 330, 169, 875, 855, 462, 441, 933, 47, 350,
    985, 377, 935, 792, 237, 941, 309, 293, 13, 462, 654, 107, 629, 861, 15, 545, 166, 299, 927, 588, 278, 455, 995, 215, 863,
    399, 529, 136, 953, 969, 279, 259, 806, 843, 452, 718, 609, 652, 265, 470, 647, 767, 501, 309, 460, 979, 482, 371, 819, 971,
    943, 14, 375, 366, 293, 409, 533, 472, 648, 447, 250, 452, 566, 651, 18, 327, 938, 894, 51, 760, 969, 253, 253, 658, 827, 488,
    275, 18, 346, 736, 146, 101, 481, 522, 162, 587, 148, 959, 381, 686, 150, 690, 714, 843, 861, 800, 479, 350, 907, 401, 101, 744,
    209, 849, 750, 58, 902, 622, 136, 569, 148, 322, 32, 239, 798, 283, 197, 831, 967, 444, 926, 257, 152, 329, 959, 10, 243, 341, 74,
    183, 471, 167, 789, 925, 839, 833, 824, 377, 839, 648, 750, 208, 37, 185, 42, 401, 700, 547, 102, 268, 642, 292, 271, 642, 422, 259,
    178, 649, 236, 915, 890, 796, 281, 548, 179, 788, 220, 167, 750, 888, 17, 459, 706, 938, 185, 923, 126, 217, 831, 643, 405, 299, 39,
    733, 480, 167, 430, 417, 535, 647, 250, 482, 164, 903, 460, 444, 838, 178, 381, 854, 441, 196, 167, 413, 348, 581, 779, 682, 2, 759,
    47, 97, 586, 532, 365, 112, 527, 324, 342, 20, 742, 356, 111, 189, 449, 779, 642, 132, 150, 318, 377, 840, 224, 438, 424, 798, 286,
    815, 495, 484, 650, 619, 11, 54, 436, 636, 289, 144, 396, 251, 13, 825, 745, 456, 420, 146, 343, 876, 380, 426, 661, 849, 567, 988,
    487, 706, 761, 898, 191, 522, 866, 952, 590, 667, 412, 589, 523, 390, 776, 881, 447, 262, 720, 175, 58, 486, 159, 962, 284, 327, 126,
    349, 42, 918, 469, 51, 822, 914, 248, 673, 654, 442, 233, 223, 373, 168, 542, 302, 436, 106, 531, 501, 221, 417, 899, 146, 463, 31,
    342, 736, 496, 678, 604, 989, 475, 50, 541, 528, 809, 828, 742, 220, 606, 846, 139, 649, 305, 185, 847, 296, 424, 959, 654, 626, 368,
    823, 137, 416, 382, 685, 212, 249, 954, 345, 383]
def has_duplicates(lst):
    print(len(set(lst)))
    return len(lst) != len(set(lst))

print (has_duplicates(subscriber_ids))



import random

# Generate a list of unique three-digit numbers
numbers = [i for i in range(100, 400)]

# Convert the list to a comma-separated string
numbers_str = ', '.join(map(str, numbers))

print(numbers_str)




